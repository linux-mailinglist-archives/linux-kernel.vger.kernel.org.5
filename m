Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22AB802CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjLDILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:11:41 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 00:11:47 PST
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52723D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:11:47 -0800 (PST)
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Mon, 04 Dec 2023 17:09:29 +0900
X-Sender: letrhee@nsr.re.kr
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 946;
          Mon, 4 Dec 2023 17:09:25 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     'Dongsoo Lee' <letrehee@nsr.re.kr>,
        'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'Dave Hansen' <dave.hansen@linux.intel.com>, x86@kernel.org,
        "'H. Peter Anvin'" <hpa@zytor.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204080217.9407-1-letrehee@nsr.re.kr>
In-Reply-To: <20231204080217.9407-1-letrehee@nsr.re.kr>
Subject: RE: [PATCH 0/5] crypto: LEA block cipher implementation
Date:   Mon, 4 Dec 2023 17:09:18 +0900
Message-ID: <002101da2689$2ddd8c00$8998a400$@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQH2yIhSQ+2fjzZfex7vEe+2daDNgLBfgS4g
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We accidentally omitted the version in the title. This patch should have been titled as follows.
"[PATCH v5 0/5] crypto: LEA block cipher implementation"
