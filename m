Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F49A7B250C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjI1SPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1SO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288A98;
        Thu, 28 Sep 2023 11:14:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9DBC433C8;
        Thu, 28 Sep 2023 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695924896;
        bh=v7CHSh9+ve/MG347ifzi1lbXLmV39sWJ3OvPBScPmuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyoqGvE02q55j4W5FXV7yvCOF1XTzpqp2Zq6MGw85t6L2h9oH4hppPcSNhxY03wZA
         W000Y+s/USSk8YOAKaK6OgqJBxyVRkqDuPrYiXbPvQ7THJGxHSBYOe/J2wonZLroUU
         zr9vFQlr+/+pE7ttrKOfxr7RfQ/1EjrPj1EFFazUuuAqP+1ii6kwlz5yzEjdf1GlDL
         Wjc92JG8h6eS7PI6TQDkjI3WxIZ1q6p8B62uDrKpBiT0XfU6miBU5xrNczLIv520vD
         Z5k8dg0V/QzK9gE68uhlB2mLzzt7o54aLA1mZJeSl2k/f+WRsarMVEqK9oDCHQlq06
         4BnVUNMw7btNQ==
Received: (nullmailer pid 1012605 invoked by uid 1000);
        Thu, 28 Sep 2023 18:14:54 -0000
Date:   Thu, 28 Sep 2023 13:14:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        conor+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: sc16is7xx: convert to YAML
Message-ID: <169592489396.1012549.9835840237712125781.robh@kernel.org>
References: <20230927160153.2717788-1-hugo@hugovil.com>
 <20230927160153.2717788-3-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927160153.2717788-3-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 12:01:53 -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Convert binding from text format to YAML.
> 
> Additions to original text binding:
>   - add rs485 reference.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 118 ----------------
>  .../bindings/serial/nxp,sc16is7xx.yaml        | 127 ++++++++++++++++++
>  2 files changed, 127 insertions(+), 118 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

