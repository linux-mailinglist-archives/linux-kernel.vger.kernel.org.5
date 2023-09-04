Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86A1791BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbjIDRNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60BCCDE;
        Mon,  4 Sep 2023 10:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53A4960DD6;
        Mon,  4 Sep 2023 17:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB172C433C7;
        Mon,  4 Sep 2023 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693847606;
        bh=8iH9LoHmLarNP75RBpd9cFBNvWQSGisdSjlHPK3soYU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EcCrAHKawqN4z3oSg7dYm33FcSjy+Y/e2O4NXIBPsK/rBoK/mGvgWe1vh3myG+lae
         cxjbGI/kzvBEhA/q/R2+8MzlPE/I9pS8OmN616SCmWHXrcnEMqH3AGyjzzjUBq06TB
         KdGWNf2aKagj0moofMVoUDcUxw+zWKYMqy/RMEOwW60ETCtVhi4XTaFe/zpITBpmq9
         K/1vM0dso4uKpLEHsWH6yhea5P78Ao+SDR/YTmToHswtejyfNwKeRibljN71S1QBRz
         UlVseUyubPAPqHDTXuYbHcxUQmcF+Z06a8s5Z61tsYURbeFudypVOybxqFStqA6S2s
         ibqzh/VY1gIfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: wifi: ath12k: add wiki link
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230829-ath12kwiki-v1-1-df37127527a1@quicinc.com>
References: <20230829-ath12kwiki-v1-1-df37127527a1@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384760347.3420994.13001979153285884423.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:13:25 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The ath12k wireless driver now has a wiki, so advertise it.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless.git, thanks.

af5ff4b78995 MAINTAINERS: wifi: ath12k: add wiki link

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230829-ath12kwiki-v1-1-df37127527a1@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

