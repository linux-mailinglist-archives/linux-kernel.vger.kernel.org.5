Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96A7EA040
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKMPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:40:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6EED67;
        Mon, 13 Nov 2023 07:40:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E89C433C7;
        Mon, 13 Nov 2023 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699890029;
        bh=Me27/o+L3cMxmjJ4DypGvAdvLbD9JyC08rfGMLC9mnU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LDW3Q4hkpVQFb4M9wuOMLOx40xmenw7eUVtKcycPtKH25Jj0lLfunw8wqJJL6CVPU
         EZVdTT6cmCSlTlYcUKZe9ii4wk4GrySMVfiR/yeNAgUGO2xbVr/a9HJclvnqGIfLLS
         px98/ZDqZevZDgK3GsX1kloTC7C/v6nuyoWbJMKx1+CrdMxLUPkFJcfeY9PIxVgKD7
         Jt8H9l6TOifbDxy1z3Mcl/krCIzn2qjJruR3ogSdV9N6CzDp17slRWE3EGm4uFK6Rd
         eLnAcYexgGaryWPho92At5KyctcNUQNvaFCKWFjON0/LTmTHZqr1Gaf+Ng9Wc9dhQJ
         UI5f3EX0uAZ0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] wifi: ath11k: Remove unneeded semicolon
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231030060225.28987-1-yang.lee@linux.alibaba.com>
References: <20231030060225.28987-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169989002541.3390604.14056212470986702410.kvalo@kernel.org>
Date:   Mon, 13 Nov 2023 15:40:27 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Li <yang.lee@linux.alibaba.com> wrote:

> ./drivers/net/wireless/ath/ath11k/fw.c:136:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7073
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8f157593689f wifi: ath11k: Remove unneeded semicolon

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231030060225.28987-1-yang.lee@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

