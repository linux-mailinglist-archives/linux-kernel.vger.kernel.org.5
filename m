Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5C75C57D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjGULJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjGULIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DD171A;
        Fri, 21 Jul 2023 04:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF37C619D9;
        Fri, 21 Jul 2023 11:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE7FC433C8;
        Fri, 21 Jul 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689937519;
        bh=K7zqp+s4CDeGyhNHIFPhw6m+qj8ULlENlAuVa/pcIzM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jj89ih0lGg7+izzBkhBsIasVUqFVHKkGe/DwXNZ3TtLvhSx57ZMc9NHGaY0Y7Z3XS
         m8ByqI62K/KJwynF5xUTAic6covFlxMmgFkgIvoJYGdXFCTAUesg0CGau/8coUEq8Y
         GEs2N/QLfsCRbAdbNem3+yy9APOEpQDTCm+1Zhj0ZAJi4yx6pkqW/aQxTz8vDpufNU
         KloxeQC0rFRVml2QJ8ofRWMI4tmyNSbdRusdlcWcbZQC+MeLnxDEWYR9IEscEhPLdl
         rAk2sO0eVrZ8I1+3npeu41oO4BEQ9qgAKzcxwZ0H+/KxColT/dISsWeonWpLfFpBcf
         oR3NTSZWHIuNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: remove space before ')'
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <f2d9a75e98698b245e5126eb425944a1@208suo.com>
References: <f2d9a75e98698b245e5126eb425944a1@208suo.com>
To:     hanyu001@208suo.com
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168993751601.2026970.14080569101846538355.kvalo@kernel.org>
Date:   Fri, 21 Jul 2023 11:05:17 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hanyu001@208suo.com wrote:

> Fixes checkpatch.pl error:
> 
> ./drivers/net/wireless/ath/wcn36xx/dxe.c:470: ERROR: space prohibited 
> before that close parenthesis ')'
> ./drivers/net/wireless/ath/wcn36xx/dxe.c:509: ERROR: space prohibited 
> before that close parenthesis ')'
> 
> Signed-off-by: maqimei <2433033762@qq.com>

ERROR: Missing Signed-off-by: hanyu001@208suo.com

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f2d9a75e98698b245e5126eb425944a1@208suo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

