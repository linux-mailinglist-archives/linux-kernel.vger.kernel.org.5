Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79547793AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjIFLVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjIFLVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:21:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9AA8;
        Wed,  6 Sep 2023 04:21:09 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qdqaq-0007aA-3Z; Wed, 06 Sep 2023 13:21:08 +0200
Message-ID: <a8d206b6-d1d8-4c9a-b82c-724c2def0491@leemhuis.info>
Date:   Wed, 6 Sep 2023 13:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Language: en-US, de-DE
Subject: Consider picking up "tpm: Enable hwrng only for Pluton on AMD CPUs"
 rather sooner than later
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693999269;407aed1e;
X-HE-SMSGID: 1qdqaq-0007aA-3Z
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi stable team, JFYI, the recently mainline commit 8f7f35e5aa6f21 ("tpm:
Enable hwrng only for Pluton on AMD CPUs") from Jarkko contains a stable
tag, but it might be worth picking up rather sooner than later, as it
fixes a regression that seems to annoy quite a few users of 6.1.y, 6.4.y
and 6.5; that's why at least Fedora is already working on picking the
fix up ahead of the stable-tree.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
