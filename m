Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71175C595
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGULLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGULLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25AF26B0;
        Fri, 21 Jul 2023 04:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4892618E5;
        Fri, 21 Jul 2023 11:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1634EC433CA;
        Fri, 21 Jul 2023 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689937873;
        bh=hC15AaY2HM+zWk65QMnTXiZVBLT00VwVI7aLdU5+an0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NXpbOvdo60cr61CTrqpswTAvyiB34JQfDDX5D7aFH02J1Ibe3ztO5luE/+/cigdr7
         6C27xP/hxObLfodLgVN0l4mP8yhoQ9ThD6DIou7y7rhnnbzQQOaLzbgFFwUpNWyW0l
         TPhf7yc2D7m0Ngcl1gaAAzP79XVx+n7NrXiGX18gbFDwz02zsS1ahrN8vwYxNxn2sb
         U1A8CQixQkdP460NWq5Qc+w97X9jYmNZaBcOLuYPtJUrquJ0X5fDrx7OzAjo1r8dJF
         2pyZVkzHJ2+FrRec9pvpMz6skdHLXMappwyNjauM1RyEF1tmx9yyCKBv8Gb0c0o+AY
         nPyn0dh3ypV5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath: wcn36xx: space required after that ','
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <8d242d729e447fe0f41af7bccc35396e@208suo.com>
References: <8d242d729e447fe0f41af7bccc35396e@208suo.com>
To:     hanyu001@208suo.com
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168993786988.2026970.3002620284292904646.kvalo@kernel.org>
Date:   Fri, 21 Jul 2023 11:11:11 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hanyu001@208suo.com wrote:

> This patch fixes the checkpatch.pl error:
> 
> ./drivers/net/wireless/ath/wcn36xx/dxe.c:233: ERROR: space required 
> after that ',' (ctx:VxV)
> 
> Signed-off-by: maqimei <2433033762@qq.com>

ERROR: 'wifi:' prefix missing: "[PATCH] ath: wcn36xx: space required after that ','"
ERROR: Missing Signed-off-by: hanyu001@208suo.com

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8d242d729e447fe0f41af7bccc35396e@208suo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

