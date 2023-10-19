Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67F7CF081
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjJSGyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjJSGyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:54:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099D11D;
        Wed, 18 Oct 2023 23:54:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC95C433C8;
        Thu, 19 Oct 2023 06:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697698484;
        bh=cgw+hrVnT04BSdx3UMXSIoT2kRzn6GIe2TVRZ0Fq+2w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TN+Okm2F9EN5Jzk5Qsv1WwKkk/WFFX3SBBpd0t1CzfNxwXokh6kKxa/L56QgunJlS
         1FD5ul2atexDLEI2aztep8MHzuvfM5r3P0HUfIikTJAuVxkUhfVWSsUqbapYZRc1GF
         GF8izHVKDWvii3qZbPqW2U513Ab0dIIuksdnR4TUNfQ6/7UAfDrJWd9LAVINM/Gi9r
         ujbQ7jRMhDG/sh09fpsHU4siTxLXWrCcIZ5/9YmCY9zn7Xf2TL1XcSP60k1cHeS3ZP
         H3WSvM8nqyXsWFAW4hWh8/vTyG+yjGGsNQOtZHqTmPWAIHw4shoEsDAlKhrJU+hH3q
         GNHWGaaGYVm0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: Clean up errors in ssb_driver_gige.h
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <23127c9a.945.18b270aa249.Coremail.chenguohua@jari.cn>
References: <23127c9a.945.18b270aa249.Coremail.chenguohua@jari.cn>
To:     chenguohua@jari.cn
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169769848179.117236.5229549898607018618.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 06:54:43 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chenguohua@jari.cn wrote:

> Fix the following errors reported by checkpatch:
> 
> ERROR: "foo * bar" should be "foo *bar"
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

We prefer not to take checkpatch fixes unless explicitly requested by
the maintainers.

Patch set to Rejected.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/23127c9a.945.18b270aa249.Coremail.chenguohua@jari.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

