Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A27D25FD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjJVU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:59:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8CADD;
        Sun, 22 Oct 2023 13:59:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFB6C433C9;
        Sun, 22 Oct 2023 20:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698008370;
        bh=HW680Nyjdn2sPjyuC26oFqzBy/xksD9kkFlNq2FbQls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KoVuVNe4vB1/jdz0baWdh63iuLrq9z/xbM68NjeTWZ5aj/uFH2GNiE0Z/6Tx1oWwG
         cCZGIC2XMHPjLCB7zyOytks5aClPGnoQ80gRvhscu5fTo8MSTt+eBK7pwMDdB174Ew
         ldyODJAzZ72zGM37tNgPXzRUqVwz8ucH8p9hZgsADPl3U+LlXFm9S/7nz/Rzl0JpEn
         vEPo0HG8+9fKQ6ZiauytxgSjSX/7j/XxoUNdr3WHQOjyhHwynLCIpXgJOu/d+qSyXL
         w95vpX2BdG4041MnhQDJBVPcfRj+PTGRXzrDw5dS4z0qLaA8kPZ7yu021llAZ2HkPZ
         CUCNdelJgt53A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507d1cc0538so3766491e87.2;
        Sun, 22 Oct 2023 13:59:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJBrxf+HcLskIj1m7/jx0ENYiRyB+51qAMufbC7dMZyY8LSKiv
        uSf17C3V0XiBD54GXuNtnoRSnLGDK9IPe0Vhng==
X-Google-Smtp-Source: AGHT+IHDN/5nZwYD/EXm3/U1KkSL7Zif4/flZGJGN0AEoRTDdt2jXysVZfPhK4kFVd/OYbw4cl6YfO6gYouOuCGHTmw=
X-Received: by 2002:a05:6512:3747:b0:500:daf6:3898 with SMTP id
 a7-20020a056512374700b00500daf63898mr4012711lfs.26.1698008369104; Sun, 22 Oct
 2023 13:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231020170225.3632933-1-robh@kernel.org> <20231022201748.GA32105@pendragon.ideasonboard.com>
In-Reply-To: <20231022201748.GA32105@pendragon.ideasonboard.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 22 Oct 2023 15:59:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+UFZBM2bon3qogsq1az4fD0PW3-O2LJgLZ7Uf0zVsw6Q@mail.gmail.com>
Message-ID: <CAL_Jsq+UFZBM2bon3qogsq1az4fD0PW3-O2LJgLZ7Uf0zVsw6Q@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: ti,ds90ub960: Add missing type for "i2c-alias"
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Oct 22, 2023 at 3:17=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Fri, Oct 20, 2023 at 12:02:24PM -0500, Rob Herring wrote:
> > Every DT property needs a type defined, but "i2c-alias" is missing any
> > type definition. It's a "uint32", so add a type reference.
> >
> > Fixes: 313e8b32c616 ("media: dt-bindings: media: add TI DS90UB960 FPD-L=
ink III Deserializer")
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> This is something I should have paid more attention when reviewing the
> bindings. I'll try to keep it in mind for the future.

No need, the tools will check for you now. :)

But the same property defined multiple times is not yet checked

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks.

Rob
