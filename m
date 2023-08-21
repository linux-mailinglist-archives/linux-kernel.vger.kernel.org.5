Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F178312D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHUTlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjHUTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1258EC2;
        Mon, 21 Aug 2023 12:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B65464396;
        Mon, 21 Aug 2023 19:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3E0C433C7;
        Mon, 21 Aug 2023 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692646864;
        bh=FUQx9TyKqHG33MB6C6Nk6beM/jCqOVRrZrugXYnTOLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJGJz2S+W9aNYDNl/lV1jkalwVIz+alVULA4flzq1FlEJeKXLBGNNdrAzV0Kz2oy6
         exAAI6oJLVbP67PFSnsBW0FLu03K6IZDbjydkfl5QI1OILLbG1cR1i10GpyCuVmGT4
         tcP/JDAM9hw1QYllyRPW/oL1iyXLo9ipROTMqFveK84ETGKqpsZSL5MbL6sBQeeDVM
         aqNZDHPCrxqMZYXLqu0e87jkkRkjkEDmbY/UawLIr//pOGmFnDHObyDh1KzyU0RyK5
         ty0ymNBVH+ObtUcVsORHOHjsUm+xZj+00Kuq3Lbb8KNWC3dUZbx7Q4YT8gjIksDU4w
         4nygFjEKH1n4g==
Received: (nullmailer pid 2173935 invoked by uid 1000);
        Mon, 21 Aug 2023 19:41:01 -0000
Date:   Mon, 21 Aug 2023 14:41:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, broonie@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, supercraig0719@gmail.com, scott6986@gmail.com,
        alsa-devel@alsa-project.org, KCHSU0@nuvoton.com, WTLI@nuvoton.com,
        SJLIN0@nuvoton.com, dardar923@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: nau8821: Add single-ended input
 feature
Message-ID: <169264686097.2173895.14562323557073774140.robh@kernel.org>
References: <20230816080006.1624342-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816080006.1624342-1-wtli@nuvoton.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 16:00:05 +0800, Seven Lee wrote:
> Add input with single-ended control.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

