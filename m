Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BAB785A01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjHWOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHWOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B24CD0;
        Wed, 23 Aug 2023 07:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D0116115B;
        Wed, 23 Aug 2023 14:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C310C433C8;
        Wed, 23 Aug 2023 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692799572;
        bh=wn2siE3uN6pWAkKWnir+ZgoWOBFDb8FchTv2dj6tr9E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=p8vyoehhyovBAx/1WHouvuktyN+2LcZUAWeO0ZU5xbHKnii9KFY2i+Oyv2wl/vuNE
         NgC/PbRjxiGE7Uxan/r04XtjJU8falzd5iRx+qOekQ8IhIiSLXbXvAJwc/+0NiUNVg
         ZgQUA8Cu55c3GXuvLIHspRBFQ0G7R/e/NyXew2QNL6ahTgo89W+JQd6PMRH5sgex3Y
         8zFcczIHxvocs+P+lBXxJj5umKG3F7cZu8nDvnfBg86Bu/MtjpJNiWLmNgI0+U7Xhb
         IJKLmRh523+pvV/Fy92ExOJVtYm4hDB3ff0VVyLaYnSXPWqYbfc/XKKGvhaJMitsfB
         TniXGBWI6FrwA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath10k: Fix a few spelling errors
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230822-ath_spelling-v1-1-8e2698759564@quicinc.com>
References: <20230822-ath_spelling-v1-1-8e2698759564@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169279956875.1241462.11254897741265211259.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 14:06:10 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Fix a few issues flagged by 'codespell'.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

3ced39049d4d wifi: ath10k: Fix a few spelling errors
d68a283bfc39 wifi: ath11k: Fix a few spelling errors
4f1dbb4904c3 wifi: ath12k: Fix a few spelling errors

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230822-ath_spelling-v1-1-8e2698759564@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

