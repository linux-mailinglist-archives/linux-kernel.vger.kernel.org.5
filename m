Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0627A21E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjIOPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjIOPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:05:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471D3AAB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:04:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B063CC433C7;
        Fri, 15 Sep 2023 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694790276;
        bh=tVYfV/FQ4TuHJ0bVqoaP+aOcfUDlOtABzOf5hv1Hfg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EweW9D8o+n+9qE2ej+Iyg7KegRJ6h600oZdgnpuS3nogKT+8Ut0LB0udvbKp6URtf
         VgVYssOyUxBbRyhE71kNoUVm6UCDS/603L0nJ9DEy2bIlm+V3nG9OmsujAHEBvlRhC
         Ea+BlYnS9B33UbSfpwh4/Msl3vJldpvv2Di+FlIGh4Ry7ts6CzrVTuaoy4B8wYt0vd
         ug0tcUtN9OHnPNf3gThuKKmRkQtGyqSc7gi71J0rxrh0ibcjtv/+SteUsAzh7JT2k6
         /u8hetHcSXSHqusB854BDIpUb+uuMsm/oh17XBRGdGbijdHV8T4MCv2PBn7qDFVeOo
         rcA/SQTj3ug+w==
Received: (nullmailer pid 3731047 invoked by uid 1000);
        Fri, 15 Sep 2023 15:04:33 -0000
Date:   Fri, 15 Sep 2023 10:04:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wang Chen <unicornxw@gmail.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH 05/12] dt-bindings: interrupt-controller: Add SOPHGO's
 SG2042 PLIC
Message-ID: <20230915150433.GA3730052-robh@kernel.org>
References: <20230915072358.118045-1-wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915072358.118045-1-wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:23:58PM +0800, Wang Chen wrote:
> Add compatible string for SOPHGO SG2042 plic.
> 
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>

Same problem with authorship and S-o-b order here.

> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index dc1f28e55266..3abb1f68ea62 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -66,6 +66,7 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-plic
>                - thead,th1520-plic
> +              - sophgo,sg2042-plic
>            - const: thead,c900-plic
>        - items:
>            - const: sifive,plic-1.0.0
> -- 
> 2.25.1
> 
