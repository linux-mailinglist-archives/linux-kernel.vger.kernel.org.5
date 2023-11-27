Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA07FA853
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjK0Rv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjK0Rv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:51:57 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EFD111;
        Mon, 27 Nov 2023 09:52:03 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1fa486a0e10so903367fac.3;
        Mon, 27 Nov 2023 09:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107522; x=1701712322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qP2c9CN5CjrhkwDV0xgvtW5t/xJO6d0tsdDX2eLr8w=;
        b=Ykef37PPVj7uvRjpsBNt6Rc96iudiJIWrBBOvzo1t3jjhEPVZblRjci+apwBg0kRli
         IP/Z49cdL9QUyWYL5u1y0h5vOnQTZR/5AffxJqgZyMGXP8+l5EqlN3c+iJJ688zOaAKx
         yVObZ06foaNXjirbZDwvZPjmuH9RyLilMQzx6gjfi6t/uKjnPpaEL/OIQMTjIo/NwZuR
         WBfdelsHhevpYic4O9dFT0pDpWUPBXM/gUFRnOOoZV02sPE3kcduPOUlhPgp3DPhjSfL
         GLN+USsRYQmwoY3IqNmfLV621HRjmcmZ9eI51Ngkai+9AZI3aUho1LOz0BnPYS18Gf+j
         t7gQ==
X-Gm-Message-State: AOJu0YzFwk533O474XFOu0+7HNfS+isyNKJZa7j5EbjWRI0yzIdcPSZX
        vqFs2+O2HbTu8r5WtSDCyg==
X-Google-Smtp-Source: AGHT+IG19I5lae8dWTQhpITCeP9FKx74DPu+CfRsHG/iq0HJR8akTbrvzMlAP81KjFrZih4SR+NR/A==
X-Received: by 2002:a05:6870:d85:b0:1f4:daf6:78cc with SMTP id mj5-20020a0568700d8500b001f4daf678ccmr15957254oab.31.1701107521903;
        Mon, 27 Nov 2023 09:52:01 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z19-20020a056870515300b001efce0658e6sm2436211oak.39.2023.11.27.09.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:52:01 -0800 (PST)
Received: (nullmailer pid 1854610 invoked by uid 1000);
        Mon, 27 Nov 2023 17:52:00 -0000
Date:   Mon, 27 Nov 2023 11:52:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: fsl,dpaa2-console: drop unneeded quotes
Message-ID: <170110751966.1854443.5792070352001940257.robh@kernel.org>
References: <20231122224419.2809361-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122224419.2809361-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2023 15:44:19 -0700, Rob Herring wrote:
> Drop unneeded quotes over simple string values to fix a soon to be
> enabled yamllint warning:
> 
>   [error] string value is redundantly quoted with any quotes (quoted-strings)
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

