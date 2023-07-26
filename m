Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2A7631C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjGZJYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjGZJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:23:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7130EE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:21:33 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOai0-0007bE-Sl; Wed, 26 Jul 2023 11:21:28 +0200
Message-ID: <ae1ad814-5613-704e-b0b1-4f1fc4bead44@leemhuis.info>
Date:   Wed, 26 Jul 2023 11:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
Content-Language: en-US, de-DE
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Atheros 11K <ath11k@lists.infradead.org>
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
 <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
 <16885654-09f0-c139-cc9b-c6c4d666932e@quicinc.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <16885654-09f0-c139-cc9b-c6c4d666932e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690363293;33dfbb81;
X-HE-SMSGID: 1qOai0-0007bE-Sl
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.23 11:17, Manikanta Pubbisetty wrote:
> On 6/26/2023 6:19 PM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> Hmmm, there afaics was no real progress and not even a single reply from
>> a developer (neither here or in bugzilla) since the issue was reported
>> ~10 days ago. :-/

BTW: Kalle, many thx for picking this up and posting & applying the revert!

>> Manikanta, did you maybe just miss that this is caused by change of
>> yours (and thus is something you should look into)?
> 
> Extremely sorry for having this missed [...]
> 
> Hi Sanjay, [...]

FWIW, Bagas Sanjaya just forwarded the report and the reporter is not
CCed afaics (bugzilla privacy policy does not allow this, which
complicates things a lot :-/ ). You have to use bugzilla to reach the
reporter: https://bugzilla.kernel.org/show_bug.cgi?id=217536

Bagas Sanjaya: wondering if you should make that "I'm just forwarding"
aspect more obvious in your mails. And it afaics would also be good to
mentioned the author of the culprit quite early in your mails, as there
is a risk that people will miss that aspect otherwise.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
