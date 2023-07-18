Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01E075819F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGRQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGRQCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:02:50 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E51984;
        Tue, 18 Jul 2023 09:02:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qLn9o-0001vO-R4; Tue, 18 Jul 2023 18:02:36 +0200
Message-ID: <2c4f2031-db2d-92c4-5476-dfd813f93d50@leemhuis.info>
Date:   Tue, 18 Jul 2023 18:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>, corbet@lwn.net,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Mark Brown <broonie@kernel.org>
References: <20230713223432.1501133-1-kuba@kernel.org>
 <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
 <20230714101028.337fb39a@kernel.org>
 <bb8c6476-283c-3bc6-710b-5a8602ccd40e@leemhuis.info>
 <20230718083753.2d1e003a@kernel.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <20230718083753.2d1e003a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689696160;13f5e5c0;
X-HE-SMSGID: 1qLn9o-0001vO-R4
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.23 17:37, Jakub Kicinski wrote:
> On Sat, 15 Jul 2023 12:31:02 +0200 Linux regression tracking (Thorsten
> Leemhuis) wrote:
>> Maintainers must ensure severe problems in their code reported to them

BTW: I wonder if "reported to them" should be removed. Or maybe it
should be "they become aware of" instead, as they might be reported to
of the the contributors to the subsystem the maintainer handles. Not
sure. Currently I think removing might be better. Judge yourself.

>> are resolved in a timely manner: security vulnerabilities, regressions,
>> compilation errors, data loss, kernel crashes, and bugs of similar scope.
> 
> SG, thanks for the suggestion!

+1

> One edit - I'd like to remove "security vulnerabilities" from the list.
> Security implications are an axis on which bug can be evaluated, one of
> many. All kernel bugs have some security implications. Placing them as
> a category like crashes, lockups or compiler errors could deepen the
> confusion.

I don't really care, but that could be avoided with something like
"security vulnerabilities known to be exploitable".

Cioa, Thorsten
