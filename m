Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADF27E5CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjKHSHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:07:35 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8BC186;
        Wed,  8 Nov 2023 10:07:33 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso4312008fac.3;
        Wed, 08 Nov 2023 10:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699466853; x=1700071653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHjvyWkMn8XrGZDkMWjodVKhnQYsI61TxWwGYF7VAwI=;
        b=gJx4AvyN0PWnkaq0jhv9kSDfLsSob5d6LbIvlt76NP+t33wfMYeAhtBZmmWYQANv+F
         Q+R978KPttK6v0v3hC3pg7V1pFEYRXN+ADLYqiiCZgHwIvezw6725Cp1lRQ4yr6R5IAC
         WXfSqx9GKAyryodv12SIWSRtRJBa2jOcKDahPeQDKotahBS+ZHitFMHHLELtTzXa4c6j
         mwklfEwtoJr6ex/8VASr/IC/vVs5SGo5JlzuXshGCAbNhjpVv+P4Emxk540muOcr+mS4
         Llg0cvIwWUohDGtDffjuKN2b2PFlqTccmLhwewLyK9bgNbMd9E29ZqhpYUvQss/iv15p
         uiHA==
X-Gm-Message-State: AOJu0YyBOBXcxDIwG3s532QCDVxwrgC3wDjBBLgQB5ICE6yFttj6LWLn
        Lg/75TAEMh0q+/YVzhrkQUdh77tkDw==
X-Google-Smtp-Source: AGHT+IGk/f1cTDnSPhUN8zxdO9+haLXQqAv5W9ADErbu9rEMdc0hyqqCcHdXAuxiKKbFSFvRFxgwTA==
X-Received: by 2002:a05:6870:1057:b0:1e9:fb1e:870f with SMTP id 23-20020a056870105700b001e9fb1e870fmr2219143oaj.37.1699466852563;
        Wed, 08 Nov 2023 10:07:32 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a6-20020a056870b14600b001ea17894928sm389045oal.21.2023.11.08.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:07:31 -0800 (PST)
Received: (nullmailer pid 2628624 invoked by uid 1000);
        Wed, 08 Nov 2023 18:07:30 -0000
Date:   Wed, 8 Nov 2023 12:07:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: overlay: enable of_overlay_fdt_apply() kerneldoc
Message-ID: <169946684712.2627764.431369348564575636.robh@kernel.org>
References: <20231106-of_overlay_fdt_apply-kerneldoc-v1-1-9a2d132bc6c1@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-of_overlay_fdt_apply-kerneldoc-v1-1-9a2d132bc6c1@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Nov 2023 14:03:24 +0100, Luca Ceresoli wrote:
> of_overlay_fdt_apply() already has a kerneldoc-formatted documentation,
> except it is nor marked as such. Adding the second asterisk is enough for
> the documentation to take it into account correctly.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/of/overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

