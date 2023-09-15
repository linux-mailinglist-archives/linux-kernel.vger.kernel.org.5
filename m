Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE837A18CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjIOI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjIOI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0F3C22;
        Fri, 15 Sep 2023 01:27:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040FCC43142;
        Fri, 15 Sep 2023 08:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765857;
        bh=fFC1jw61OTix2DWS7/ncGs4xq27X8yWSfDU5VGasx5k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uVB6fr/cpGQpb81G4sPLflS+dAFm6jZwTvI9r14VWp13+hfCf/0WaN0uC98iS08kc
         0uP4Cy4OLNjDY5ulOCtSsWM36TusiU4o6QkziN2Rvq1cqK91ytkPCbRHyuuN5ScPAq
         tZjbVSwETcB0KmurCgvtfJVxu/ZDvR9XP2RU1+S1ZrIHrgvd4APgb8x+Yx/Zf0+1Xj
         19V5ZeLzRYuqrbqPLtMRYHjQe+QTHwTYOkBhuOwfn87djP96Kw+R0c8Sgzbhq9ILdv
         FqaiWKKj2Ia7OLc4DsHm6AjaaYSxggXJ5ewVeml/8tn1bqWQNlpHveWIe08VxEV254
         s+Dd0A88qy8qg==
Message-ID: <b3093f17-9329-dae7-0aae-df9e056d2564@kernel.org>
Date:   Fri, 15 Sep 2023 17:17:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 28/42] ata: pata_ep93xx: add device tree support
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-28-a1d779dcec10@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230915-ep93xx-v4-28-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 17:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add OF ID match table.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Acked-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

