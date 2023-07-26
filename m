Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A7763476
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjGZLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjGZLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:02:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556110EC;
        Wed, 26 Jul 2023 04:02:51 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOcI2-0002aO-AM; Wed, 26 Jul 2023 13:02:46 +0200
Message-ID: <cbc3f335-fc6a-f45a-4a08-f31bda1efd88@leemhuis.info>
Date:   Wed, 26 Jul 2023 13:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Another regression in the af_alg series (s390x-specific)
Content-Language: en-US, de-DE
To:     David Howells <dhowells@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <31ddce1d-6014-bf9f-95da-97deb3240606@leemhuis.info>
 <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
 <20079.1690368182@warthog.procyon.org.uk>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20079.1690368182@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690369371;464acef4;
X-HE-SMSGID: 1qOcI2-0002aO-AM
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.23 12:43, David Howells wrote:
> "Linux regression tracking (Thorsten Leemhuis)" wrote:
> 
>> What's the status wrt to this regression (caused by c1abe6f570af from
>> David)? It looks like there never was a real reply and the regression
>> still is unresolved. But maybe I missed something, which can easily
>> happen in my position.
> 
> I was on holiday when the regression was posted.

Welcome back. And, no worries, I was just wondering what was up here.

>  This week I've been working
> through various things raised during the last couple of weeks whilst fighting
> an intermittent apparent bug on my desktop kernel somewhere in ext4, the mm
> subsys, md or dm-crypt.

Good luck with that!

> I'll get round to it, but I'll I don't have s390x h/w immediately to hand.

thx! Ciao, Thorsten
