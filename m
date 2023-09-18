Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E3F7A5427
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjIRUaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:30:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F5CB6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:30:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C1CC433C8;
        Mon, 18 Sep 2023 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695069039;
        bh=DprrhIgDzelvIyTWIr8SzEXHEnNRh4jr4L7DY+L6emo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJlG/awENwdxcwFxJlc1MwJX/+v8YirCPiKNbHUqYoI+WJYdYGzrFuwaEnwhPGEzm
         uDdDiWxLHbqUFiaI7vJgUVzqgWy048P7VX2iQ9s6YhYd0N5HzuH/AHo/+CyUcMFI95
         GQymhqgdw9mXMdTK5n+6Jq7WunLJocXlxyBs3Mtv1VLggfn9nvHpj7rhHLi25Sy3S6
         SNRajqFCrNxC0RrXgaF9vw7SALDJ7DnKkJgzKr7cnznuMFbA46ME41Xxxn1jVvgyKu
         jeD8UvDWPtdAj5+NnHnUvcit5++VQCOpTiROFa5ayQHCBeuGtHZbrk9hmVU0p6g9T/
         iv7lM11J5EcUQ==
Received: (nullmailer pid 1723759 invoked by uid 1000);
        Mon, 18 Sep 2023 20:30:36 -0000
Date:   Mon, 18 Sep 2023 15:30:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     netdev@vger.kernel.org, erkin.bozoglu@xeront.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mithat.guner@xeront.com, Daniel Golle <daniel@makrotopia.org>,
        Eric Dumazet <edumazet@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: mediatek,net: remove
 reference on top level schema
Message-ID: <169506903453.1723676.13767276753325939381.robh@kernel.org>
References: <20230917124723.143202-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917124723.143202-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Sep 2023 15:47:22 +0300, Arınç ÜNAL wrote:
> The top level schema does not represent an ethernet controller, the
> subschema defining the MAC nodes does. Remove the reference to
> ethernet-controller.yaml on the top level schema.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  Documentation/devicetree/bindings/net/mediatek,net.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

