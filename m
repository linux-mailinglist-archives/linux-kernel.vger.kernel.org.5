Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835737F2783
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjKUIcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:32:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D395
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:32:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC31AC433C9;
        Tue, 21 Nov 2023 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700555535;
        bh=qyOqw1vmpf9f3BB2JiFLuh6XeTrJmOiGfETBWHfF9bM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uc2JScwOoas3p4YQlTcq1HZNtLPQ3XBZ/jIZD/j4lHwBYd2YYAqucpkgzUt8mJldS
         iJeHRYavrO240i+wOIF2UAyJkjBlMb1i/LbvF1kCd9nq5DtkQTi2841jby8k/eepre
         Glp4Bv0lkwsh3Gw38CFLN3Hbtr+5GPIgkUsxIWhsrqNMnAvswiXD7NmTrKzH6I74qA
         px4IUQZvo/T2W96Smplqs1BfoEtOHZ0E0+YfFPjxgdE39Ygoy/Y5mSPt1wfgqrs8HR
         jg+nSFTeaEuJPsHxZyddTH9hXR2pPLV+jrkdPExtbeDo9QM00PBz3C5WXgYUQVIWWF
         cE5DnGnLfb/aQ==
Date:   Tue, 21 Nov 2023 09:32:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yihong Cao <caoyihong4@outlook.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: apple: add Jamesdonkey and A3R to non-apple keyboards
 list
In-Reply-To: <SYYP282MB2110B4E87983EAFEDC8741E49BA2A@SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM>
Message-ID: <nycvar.YFH.7.76.2311210932060.29220@cbobk.fhfr.pm>
References: <SYYP282MB2110B4E87983EAFEDC8741E49BA2A@SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023, Yihong Cao wrote:

> Jamesdonkey A3R keyboard is identified as "Jamesdonkey A3R" in wired
> mode, "A3R-U" in wireless mode and "A3R" in bluetooth mode. Adding them
> to non-apple keyboards fixes function key.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

