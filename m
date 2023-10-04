Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6877B7739
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjJDEpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjJDEpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:45:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A24690;
        Tue,  3 Oct 2023 21:44:56 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qntkk-0007Y7-3n; Wed, 04 Oct 2023 06:44:54 +0200
Message-ID: <ac755d6d-7b3e-45b7-bd1f-e2c79de9d8eb@leemhuis.info>
Date:   Wed, 4 Oct 2023 06:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
Content-Language: en-US, de-DE
To:     enc0der <enc0der@gmail.com>, Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me> <20231002185053.GB402943@wp.pl>
 <CAEXpi5StYwujiTaH2_5PE9Hg_cgzAEtBuFxfgVxEJvbqRNv_4A@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAEXpi5StYwujiTaH2_5PE9Hg_cgzAEtBuFxfgVxEJvbqRNv_4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696394696;201ff504;
X-HE-SMSGID: 1qntkk-0007Y7-3n
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.23 03:34, enc0der wrote:
>
> [ 1542.248686] CPU: 3 PID: 29 Comm: ksoftirqd/3 Tainted: G        W
> OE     5.10.120-tegra #1

FWIW, 5.10.120 is ancient from the upstream perspective. And I assume
that "-tegra" indicates that this is a vendor kernel that most likely is
heavily patched -- and those changes might be the reason for the
problem. Therefore you should report this to your vendor. See "Make sure
you're using the upstream Linux kernel" in
https://docs.kernel.org/admin-guide/reporting-issues.html for details.

If you want help from the upstream Linux kernel developers, please
reproduce the problem with latest mainline.

Ciao, Thorsten
