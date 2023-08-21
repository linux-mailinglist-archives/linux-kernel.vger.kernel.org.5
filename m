Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E4782AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjHUNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjHUNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C6CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A35BC6351A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AA2C433C7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625077;
        bh=e0qCqVH45WOWXlbX5YfeDUA7pYf3ESOYKLnXCxNgJ/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KFsouREKeHbrohy/XneOtR4B4DTl5ScI5KD8XfwxnQk9S3oyFvLYCzkDDWo9O61fB
         claBjsBvosJrhWpfq7V8GrkdDWaIC3rV774uSO2S6PvRh5bXgkI6xoLXTAm7DEV+y6
         JKl7n4ZeHIVQ4mKtEcish9Vw7/rJRwh8pbrmTa/Ico2zoAEoows0hStRZW1o26Xis9
         Kp6cVA+8cJ1cM9VLr8THbW0V42eM3VAQOs9CMplcQFgZZgUAtYP6aN7PsLMX/uXiFU
         I+LpauWsQIerOR5f4bf0gGC92SXQ7dLW3C4WVPBeCJkP3idjTPXm6Q4oH8I6wbVOXO
         7LYhjbExH9uag==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so26626961fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:37:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmCcNbIqFijCCUg5gyKDCrM7tg64t4IrQQMMynX/jRL10MIkiD
        PKpez36wNaoUiq0IpC+5wEAD0/SN6MGG9hPIkQ==
X-Google-Smtp-Source: AGHT+IGWLly4v4Xj/FaBEYhu4mNSezrvpVv6/3dVIZzCJehf94hIeISJtPmaki8S1WgCVD9Uj+g4mib8rWYcKUfLXTA=
X-Received: by 2002:a2e:904d:0:b0:2b6:e2c2:d234 with SMTP id
 n13-20020a2e904d000000b002b6e2c2d234mr4970140ljg.33.1692625075072; Mon, 21
 Aug 2023 06:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230717081544.1068254-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20230717081544.1068254-1-dmitry.osipenko@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Aug 2023 08:37:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLiCPmu_NN_yuDRjVm52jRU08fpyV1MjJrY8+2OZauNUA@mail.gmail.com>
Message-ID: <CAL_JsqLiCPmu_NN_yuDRjVm52jRU08fpyV1MjJrY8+2OZauNUA@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add Boris Brezillon as Panfrost driver maintainer
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 3:17=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add Boris Brezillon as Panfrost driver maintainer. Boris is a new lead
> developer of the Panfrost Mesa driver and main developer behind the
> upcoming Panthor kernel driver that will serve next-gen Mali GPUs.
>
> Remove Tomeu and Alyssa, who left Collabora and stepped down from working
> on Panfrost.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d6536fef2fc..08dc75916148 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1615,9 +1615,8 @@ F:        drivers/gpu/drm/arm/display/komeda/
>
>  ARM MALI PANFROST DRM DRIVER
>  M:     Rob Herring <robh@kernel.org>
> -M:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
> +M:     Boris Brezillon <boris.brezillon@collabora.com>

If not applied already, put Boris first. I'm not really too active on panfr=
ost.

Rob
