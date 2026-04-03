#include <iostream>
#include <vector>
#include <cstring>
#include <stdint.h>
#include <bit>

#define MSG_SIZE 56
#define FRAME_SIZE 64

static const uint32_t k[64] = {
	0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,
	0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,
	0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,
	0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,
	0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,
	0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,
	0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,
	0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2
};

static uint32_t hash[8] = {
    0x6a09e667,0xbb67ae85,0x3c6ef372,0xa54ff53a,0x510e527f,0x9b05688c,0x1f83d9ab,0x5be0cd19
};


typedef struct {
    char       msg[56];
    uint64_t   size;
} __attribute__((packed)) msg_frame_t;

typedef struct {
    uint32_t       w[64];
} __attribute__((packed)) msg_schedule_t;

uint32_t sig0(uint32_t x) {
    return std::__rotr(x, 7) ^ std::__rotr(x, 18) ^ (x >> 3);
}

uint32_t SIG0(uint32_t x) {
    return std::__rotr(x, 2) ^ std::__rotr(x, 13) ^ std::__rotr(x, 22);
}

uint32_t sig1(uint32_t x) {
    return std::__rotr(x, 17) ^ std::__rotr(x, 19) ^ (x >> 10);
}

uint32_t SIG1(uint32_t x) {
    return std::__rotr(x, 6) ^ std::__rotr(x, 11) ^ std::__rotr(x, 25);
}

uint32_t choice(uint32_t e, uint32_t f, uint32_t g) {
    return (e & f) ^ ((~e) & g);
}

uint32_t majority(uint32_t a, uint32_t b, uint32_t c) {
    return (a & b) ^ (a & c) ^ (b & c);
}

int sha256sum(const char* dat, const unsigned int& m_size) {
    msg_frame_t frame;
    msg_schedule_t sched;
    // 0 out block
    for (int pad = 0; pad < MSG_SIZE; pad++) {
        frame.msg[pad] = 0;
    }

    memcpy(frame.msg, dat, m_size);
    frame.msg[m_size] = 0x80;       // append '1' bit
    frame.size = htobe64(m_size * 8); // write size as little endian
    
    // copy 1st chunk into sched array
    memcpy(&sched, &frame, FRAME_SIZE);

    for (int i = 0; i < 16; i++) {
        sched.w[i] = be32toh(sched.w[i]);
    }
    // calculate the rest of the schedule
    // formula:
    // w[i] = w[i-16] + sig0(w[i-15]) + w[i-7] + sig1(w[i-2])
    for (int i = 16; i < 64; i++) {
        sched.w[i] = sched.w[i-16] + sig0(sched.w[i-15]) + sched.w[i-7] + sig1(sched.w[i-2]);
    }    

    // initialize working vars
    uint32_t a = hash[0];
    uint32_t b = hash[1];
    uint32_t c = hash[2];
    uint32_t d = hash[3];
    uint32_t e = hash[4];
    uint32_t f = hash[5];
    uint32_t g = hash[6];
    uint32_t h = hash[7];

    for (int i = 0; i < 64; i++) {
        uint32_t t1 = h + SIG1(e) + choice(e, f, g) + k[i] + sched.w[i];
        uint32_t t2 = SIG0(a) + majority(a, b, c);
        h = g;
        g = f;
        f = e;
        e = d + t1;
        d = c;
        c = b;
        b = a;
        a = t1 + t2;
    }

    // add compressed chunk to current hash value
    hash[0] += a;
    hash[1] += b;
    hash[2] += c;
    hash[3] += d;
    hash[4] += e;
    hash[5] += f;
    hash[6] += g;
    hash[7] += h;

    // print hash
    for (int i = 0; i < 8; i++) {
        std::cout << std::hex << hash[i];
    }

    
}

int main() {
    // Message block (512 bits / 64 bytes)
    // First 56 bytes are message
    // Last 8 bytes are length

    const char v[] = {0x74, 0x65, 0x73, 0x74}; // test

    sha256sum(v, 4);

}