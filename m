Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628047FD5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjK2L2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjK2L2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:28:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8061FD6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:28:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775FAC433C7;
        Wed, 29 Nov 2023 11:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701257294;
        bh=joqrS32XswqG+vdfwGQq1R1sy9R+ce2w4Zv2Sanz8BU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Q44/QKj5gAVm7sCFTy/pO4mK/fDd6RRvG9f0HR0Gp03d/2iiEhIwoq5NrLOXV/0Fq
         2M2+31+k3B8g4d4BwmeIB28guStAL5qoZeoO3puzzfowOb7z8JLUr5sXM2rGGZQqTJ
         8ZrhQsPyw4TzDxf1MVQOoscZUnBJnLGIzjrsDxkF9EOUJ14XGjrT0075A72yDsnqFx
         18O4AcegJFnx2OXAuOm52Dp6LtEk8LD3jQ3LyGyzmmy9XpRvfg0+Pic20RWGmAnQfy
         zZdF/InDWJhigmAWvkgD1mm/kNaEFPkHtkq9sZMXpd3NSGEuqw26Dqq7GhASWNB67H
         JIzonJ0EcqhDg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 wireless-next 9/9] wifi: ath9k: Remove unnecessary
 (void*)
 conversions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919045226.524544-1-yunchuan@nfschina.com>
References: <20230919045226.524544-1-yunchuan@nfschina.com>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     toke@toke.dk, afaerber@suse.de, mani@kernel.org,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170125729061.1070846.16035596415965812911.kvalo@kernel.org>
Date:   Wed, 29 Nov 2023 11:28:12 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> wrote:

> No need cast (void *) to (struct owl_ctx *), (struct ath_hw *),
> (struct cmd_buf *) or other types.
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d6e71dd1e49e wifi: ath9k: Remove unnecessary (void*) conversions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919045226.524544-1-yunchuan@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

