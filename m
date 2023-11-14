Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19137EB366
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjKNPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKNPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:21:59 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDFA11A;
        Tue, 14 Nov 2023 07:21:55 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-58a737957d3so285464eaf.0;
        Tue, 14 Nov 2023 07:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975315; x=1700580115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J15sEa7zSm5u7jaEkjftn3VCZWspXJk6JRoiiJKaDmk=;
        b=ZQ2lwwq0HjEbFuJFeUlNE2nacQ7OSoleZomGaIdhkGC27C9SuofrXHoC5JUxTGca5J
         XJ7Q4rdk4Nop9X7IEiNEbmpZ1yHbwgvj85WUwYE0EjYTM7J0thZ8Jd9+WbQY/g27o9oj
         EEHbEHQdo8oDPUOlcReLxJhNAIMOxCUoQa3EC+5qLQPy1K6GQIhf4eU5a7t3ZDABYmEB
         jswTfO4n0+jhVUKJUsAgjbMN1cMmjTgehD+B21xSRqyrTunsIPq8qv6hYTmBfn7Tm7no
         yYpGymrpNwqE5Sie9xko3ukyHPbSe7c0+GcJvhSqJp5hkaNgjSHeJBjQObm71oFU6TW+
         jJeg==
X-Gm-Message-State: AOJu0YyVHkn+0OmZn99GohQTKPzhj1LPsT9mILVFUCom9EHPodUmJqeU
        5YbOV6hjYTiuCggTVWVFSw==
X-Google-Smtp-Source: AGHT+IHMXoKiyNylaIR+nukyu3BetutomYr9uKiRQo/BwHNE+zS/4TczHyQs3K2bQgl/iosqC+11wQ==
X-Received: by 2002:a4a:b588:0:b0:58a:67b1:47ca with SMTP id t8-20020a4ab588000000b0058a67b147camr2790634ooo.6.1699975315188;
        Tue, 14 Nov 2023 07:21:55 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u188-20020a4a57c5000000b00587bf56d2desm281035ooa.26.2023.11.14.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:21:54 -0800 (PST)
Received: (nullmailer pid 1872956 invoked by uid 1000);
        Tue, 14 Nov 2023 15:21:53 -0000
Date:   Tue, 14 Nov 2023 09:21:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: gpu: samsung-rotator: drop redundant
 quotes
Message-ID: <20231114152153.GA1704371-robh@kernel.org>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
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

On Sun, Nov 12, 2023 at 07:43:59PM +0100, Krzysztof Kozlowski wrote:
> Compatibles should not use quotes in the bindings.

Unfortunately yamllint skips checking these due to a bug handling 
bracketed lists. There's an open issue for it[1].

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/gpu/samsung-rotator.yaml         | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

[1] https://github.com/adrienverge/yamllint/issues/516
