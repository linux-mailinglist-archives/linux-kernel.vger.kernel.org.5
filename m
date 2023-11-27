Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792917FA858
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjK0RwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjK0RwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:52:10 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590119D;
        Mon, 27 Nov 2023 09:52:17 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d7f67a99c7so1970255a34.0;
        Mon, 27 Nov 2023 09:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107536; x=1701712336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5vq4/MaD1JHsioKPmE21zFRAWDJTMjzCE0jVGTeBpw=;
        b=Ps5LtzX1HJlQsZgHntEcu4kAASo+ta3qpgoXhfWKPrd5IvJhlLC4r5Y5bh3KEd+Bnd
         GbvW9/VCISSm1CzF/Qs0Kb9ZqnOBqVTDuUUcQmzy/dvWl15YBSokXuKyVxKnmym66ZPn
         4pdDfUxxRpsPq+3PrDlNt+HlyG6UEGZFLmMX2g+ojEN87dESGah8O3fDuEU2feysh2S2
         pxNoAxmy2qErFLV8A++0c3OacyXXfN7dckD354r+Kwv/+r1lJUq0ODeWZmEVYhylzTl3
         PZtocprLu4oAR1tTjqtqRl7v+360ALZw+Ah5MK22RVwikJqIoHNkaU57RcHmWCd6qbFp
         anIQ==
X-Gm-Message-State: AOJu0Yytv+noBikl5FqfAZgiy1VMONvG95ptm9lrNcjkGRpv/Tr52Jre
        zReSt0GYZqUBFx0m8HNCrSiXtwDcNg==
X-Google-Smtp-Source: AGHT+IHtht0CxcgrKqlVZ+UcNyjOVxuLCylbip04h8a+kkwFZaGUcSgQBxuFiocJmgsUq1NZ0qj9ug==
X-Received: by 2002:a9d:6047:0:b0:6d8:24a:deb4 with SMTP id v7-20020a9d6047000000b006d8024adeb4mr6790078otj.10.1701107536484;
        Mon, 27 Nov 2023 09:52:16 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a4a7644000000b0058d458b5420sm1195054ooe.47.2023.11.27.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:52:15 -0800 (PST)
Received: (nullmailer pid 1856922 invoked by uid 1000);
        Mon, 27 Nov 2023 17:52:15 -0000
Date:   Mon, 27 Nov 2023 11:52:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm/calxeda: drop unneeded quotes
Message-ID: <170110753407.1856696.15594654291355482500.robh@kernel.org>
References: <20231122224432.2809781-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122224432.2809781-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2023 15:44:32 -0700, Rob Herring wrote:
> Drop unneeded quotes over simple string values to fix a soon to be
> enabled yamllint warning:
> 
>   [error] string value is redundantly quoted with any quotes (quoted-strings)
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

