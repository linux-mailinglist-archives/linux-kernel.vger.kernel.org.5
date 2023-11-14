Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903917EADAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjKNKMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:12:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661D197;
        Tue, 14 Nov 2023 02:12:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D9AC433CA;
        Tue, 14 Nov 2023 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699956735;
        bh=iP63dGchT/mcMGynew2nmY3GkfdzRSlWb+IEwotHkDk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eCXpabQX8tMxPdefvOM7ubvqK7TTMxqGuoKdXHHxZDy263ap/Y//cqFV5+o9rbSch
         ZNtPYzs2oU65cVspZutesdovjnMQ6tI0U0A2osdkpsGUmZoVGGQGhBKagDtKymecK7
         kt2bQcoA42x41ILH1ttCoYBmytvkjeEK2rabi3VzAHA8aj8wI1H4Pcak3RSWEVYymF
         vypM+qOGVulRu/HieYkPGC4X+AmbK3ez4dzHlRTfsW3asmFvmlo2hPgBis5RrcWsbT
         AGuG2GJFxklaCYmP8i53reeF9xtRYh0nmo/0dog2ijcypyi6pc1jUfDXt5bB7FBmHw
         t0sc5cMfcfNJQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: libertas: stop selecting wext
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231108153409.1065286-1-arnd@kernel.org>
References: <20231108153409.1065286-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Amitkumar Karwar <akarwar@marvell.com>,
        Kiran Divekar <dkiran@marvell.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169995673108.3786790.13602190605646892618.kvalo@kernel.org>
Date:   Tue, 14 Nov 2023 10:12:13 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Libertas no longer references the iw_handler infrastructure or wext_spy,
> so neither of the 'select' statements are used any more.
> 
> Fixes: e86dc1ca4676 ("Libertas: cfg80211 support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to wireless-next.git, thanks.

8170b04c2c92 wifi: libertas: stop selecting wext

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231108153409.1065286-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

