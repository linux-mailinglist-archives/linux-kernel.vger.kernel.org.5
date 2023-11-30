Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16A7FF7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345841AbjK3RCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjK3RCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45883
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:02:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93413C433C7;
        Thu, 30 Nov 2023 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701363761;
        bh=kO+tnUITBtUkmCBdvTfQ2GZDs3tBiJ+5QDKUMcdiWiQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HsKOulHiEFMsie379PAyzTppAf+fKQ5a7JnlnEyQRPoYOR1P8kumyu09/gj56nDPh
         gAIs7ZXgxCNAkStlAxaa9F0ZSwrGktOEZJcb5TUmUsUohCwMcQPk0mlhTZkl74fX4E
         zzNfHcioHZbu+mo28SbXBZK8i8pdMKoH8HXkswu1sc8eG2YlDoHBWCQ2CA6QpJfjXV
         NB7CJK023lMTfw2idbwJ0yDa8YX+qJFLAjBpdEfD0op4CsYn7yVps/2ufWBTqj7JjW
         IdI4OEEnEExiV1Ma4P7BIEJHRrglU0W8ltn3mKw6TzGktIsKSvuj9RPENFvCt3u3Dl
         m8A+YYeDNl9yQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath10k: remove ath10k_htc_record::pauload[]
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231127-flexarray-htc_record-v1-1-6be1f36126fd@quicinc.com>
References: <20231127-flexarray-htc_record-v1-1-6be1f36126fd@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170136375770.1435047.461679171270420722.kvalo@kernel.org>
Date:   Thu, 30 Nov 2023 17:02:39 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The misspelled pauload member of struct ath10k_htc_record is unused,
> so remove it.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

c7876faa91ab wifi: ath10k: remove ath10k_htc_record::pauload[]
7b4df59fced0 wifi: ath10k: Use DECLARE_FLEX_ARRAY() for ath10k_htc_record
f20eb4cb9324 wifi: ath11k: remove ath11k_htc_record::pauload[]

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231127-flexarray-htc_record-v1-1-6be1f36126fd@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

