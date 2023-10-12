Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180977C7212
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbjJLQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjJLQH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:07:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E40BB;
        Thu, 12 Oct 2023 09:07:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0CDC433C8;
        Thu, 12 Oct 2023 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126877;
        bh=6ENE6DkC6NwZYLerRQYJIEfjH4f0qJlAvrCx99RM68w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RF4FUB63xnf6DJqAQLZwvC1v4od6qWgdBIzKk2HqThd+cPfXalik7qFILDF66KTe6
         Nk94ju6wIaq9HTAf7DlE5gE/U45+MT7kTIP/1iPzXCBsLMI62EUVigFlQ+UQ4z4Lbz
         r8wsjbCkWHzGJf2cE482QaQrBVHath9H62VehULjxNPwA3rBcD6+Crt5/dn/+gYYZI
         bI2MB/YpwVV0WzEaKMVFHPSJbXxe4Quk/EZiPSOF2s7ptTFlIAVNIr4RFLtdkDP0bo
         qdEWDKNxigEYMB86S8FiVS0ZjGuo+HQ7MegvBJ6idQiPzqPUS7D3zEja5taTDVggm+
         wIJxtnH6zVk5Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Remove unused struct ath11k_htc_frame
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231009-ath11k_htc_frame-v1-1-81d405b7a195@quicinc.com>
References: <20231009-ath11k_htc_frame-v1-1-81d405b7a195@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169712687405.3501995.7242632853921809220.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 16:07:55 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> struct ath11k_htc_frame is unused, and since it illogically contains
> two consecutive flexible arrays, it could never be used, so remove it.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

480d230bef0e wifi: ath11k: Remove unused struct ath11k_htc_frame

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231009-ath11k_htc_frame-v1-1-81d405b7a195@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

