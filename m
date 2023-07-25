Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E0761BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjGYOcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjGYOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31526A5;
        Tue, 25 Jul 2023 07:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91148616C2;
        Tue, 25 Jul 2023 14:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7ECC433C8;
        Tue, 25 Jul 2023 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690295470;
        bh=XmCKpO0xZh6n2LHZjihXh+ZT81DATlQJJfR5qhoCSJ8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LhQii826j305zDpex9+8DM1mIvNbZPDxLraU3NlWHACpWCRdMezndcqXJ4PZkS1KQ
         R7O1IolwGhn/3SaBq1BlQR5scnofWi+e2DMA4r7XDRW7KacL4S5hNCdcHiuRVNICme
         1wY6JdpE8ZnEFpVZ7fVQ/2wbH6gYtJuePiccxX82800zG2wyvsn0ih1KFtmzODoRLR
         Y1ZXOX00D8jR876gonBlnsZhw7egCjIRd42Vmyn/PJGCemddQPCkuohW31XDWHf3Pe
         dfIeAr4cDfEE75lYwiuySKnHsYKWvElOixiKP3FrP+Wn0TwO5b6/kVXrymzoBlqgzH
         hyBW1syZnwtsg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v3] wifi: ath6kl: Remove error checking for
 debugfs_create_dir()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714014358.514-1-machel@vivo.com>
References: <20230714014358.514-1-machel@vivo.com>
To:     Wang Ming <machel@vivo.com>
Cc:     Wang Ming <machel@vivo.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        quic_jjohnson@quicinc.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029546655.3210124.18169307395906064976.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:31:08 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> wrote:

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in ath6kl_debug_init_fs().
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1301783c8def wifi: ath6kl: Remove error checking for debugfs_create_dir()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714014358.514-1-machel@vivo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

