Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF97A7463
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjITHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjITHik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:38:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6177110
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:38:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FAFC433CA;
        Wed, 20 Sep 2023 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195514;
        bh=4NlRl7tmZMlfASt9XMRrxPS/AlpbPNnFQnsAF66CTlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fbOv5Ga5pOr8bEBqOsDmwv+qo+NkSh7hSrqE9C/EQnXiA7C5v9Cy5dCGE8jSKmdvZ
         O/v5Zatn42gteY9WxSpqTymCnb+ixM0XX4DLLgN1Fxilum3hjw9q7y+mgHeszDM7Bs
         ZPb0wsc18lBuK3JclBPaONYI54BGmI598o12WgsYaHKLv6501kgIK9onNvHdK3ax4u
         y7maDMUZ1dknByW8d3NcpRbqLW41yrtOQ4uPfFsqhe/VjGoK20ddyGNieIS7+YSb54
         BVb4lyyQbfTv4ycjdl/l3GGArDJ9MdgZAPCHSQxqyEqih+GGENIEgbmA17AmTbRAXc
         YzzS4LEzKCnRQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9a64619d8fbso861234366b.0;
        Wed, 20 Sep 2023 00:38:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzUNQF7lxBckkheGlZmT5X2Zpx6N7AV0IlSOJbD3pHEukZjonFO
        4Dywowy7oq1Vj+0lsWGAj7LNofIl/L58tnfq9aE=
X-Google-Smtp-Source: AGHT+IGLN8EgkEV3ltTwt+G6aGQQKtZQniuqxBAE1MIL3EKm4G4pYEaRbZGEIQOkUwjSiwQT7EJF3oIY42lCYaKF3b0=
X-Received: by 2002:a17:906:3694:b0:99b:627b:e96d with SMTP id
 a20-20020a170906369400b0099b627be96dmr1221708ejc.44.1695195512786; Wed, 20
 Sep 2023 00:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <dbd7d823a73d8a9484efcd55f6616f5392daf608.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <dbd7d823a73d8a9484efcd55f6616f5392daf608.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 15:38:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRd=G+-zzFXEF+XUT3vLtfeHJknODoTWUVP36hy-7MoRg@mail.gmail.com>
Message-ID: <CAJF2gTRd=G+-zzFXEF+XUT3vLtfeHJknODoTWUVP36hy-7MoRg@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] dt-bindings: vendor-prefixes: add milkv/sophgo
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:37=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> Add new vendor strings to dt bindings.
> These new vendor strings are used by
> - Sophgo SG2042 SoC [1]
> - Milk-V Pioneer board [2], which uses SG2042 chip.
>
> [1]: https://en.sophgo.com/product/introduce/sg2042.html
> [2]: https://milkv.io/pioneer
>
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 573578db9509..fcca9e070a9a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -863,6 +863,8 @@ patternProperties:
>      description: MikroElektronika d.o.o.
>    "^mikrotik,.*":
>      description: MikroTik
> +  "^milkv,.*":
> +    description: MilkV Technology Co., Ltd
>    "^miniand,.*":
>      description: Miniand Tech
>    "^minix,.*":
> @@ -1273,6 +1275,8 @@ patternProperties:
>      description: Solomon Systech Limited
>    "^sony,.*":
>      description: Sony Corporation
> +  "^sophgo,.*":
> +    description: Sophgo Technology Inc.
>    "^sourceparts,.*":
>      description: Source Parts Inc.
>    "^spansion,.*":
> --
> 2.25.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
