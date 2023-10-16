Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94D7CA142
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjJPIHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjJPIHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:07:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9CDE;
        Mon, 16 Oct 2023 01:07:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qsIdV-0000s6-09; Mon, 16 Oct 2023 10:07:37 +0200
Message-ID: <0ee79296-a404-4d0d-b8ed-42578a77692c@leemhuis.info>
Date:   Mon, 16 Oct 2023 10:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] Bluetooth: btrtl: Ignore error return for
 hci_devcd_register()
To:     patchwork-bot+bluetooth@kernel.org, Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com,
        regressions@lists.linux.dev, kirill@shutemov.name,
        bagasdotme@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20231006024707.413349-1-max.chou@realtek.com>
 <169664042379.23949.8315443049400174883.git-patchwork-notify@kernel.org>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <169664042379.23949.8315443049400174883.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697443660;7f753178;
X-HE-SMSGID: 1qsIdV-0000s6-09
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.23 03:00, patchwork-bot+bluetooth@kernel.org wrote:
> 
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

Hi Luiz. Many thx for picking this up. From the branch name is sounds
like you plan to submit this change in the next merge window (If I
misread the signs feel free to ignore this mail!). Wouldn't it be better
to merge this in this cycle, as the commit afaics fixes a regression
that was only introduced this cycle?

Ciao, Thorsten
