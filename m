Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2B7BBCBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjJFQcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjJFQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:32:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF703D8;
        Fri,  6 Oct 2023 09:32:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753EFC433CA;
        Fri,  6 Oct 2023 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696609947;
        bh=NDEwZEYLQ59+Tkgi6iv1hJHJNcEJX3Z7ZfJpnF3P5zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXJCdlAlBzbyfAkmXfhJXArXmwSjjV6y66rUWUvfTlkM1BkC8gam/0gKJ42kcCVHk
         HdKJftOxttOBweofKlbzZUg1WW6TF2tgLJbog5q7lFNZ1AMD7qJaEHfIDCfDvZgj8V
         Jt28nW3v/yBXM38cwYOv3pcCTC9noG9fbVI95nWtr/c8uahO2Ks/5OYgoYDHKrl1ZJ
         OAE0TVYXXPW5aYVaZjPanH/24oyYA24YPZUcXsIdhNzoDW6ilXskkwuXtLWCN9MckD
         8EGDK9A1TtIIqi3mljdXgIPjVMiuuY0OG/0UwZqg5neIkZXPUvy/o/2xs8g/+4nDXr
         0bv32emaRSBWQ==
Received: (nullmailer pid 4040234 invoked by uid 1000);
        Fri, 06 Oct 2023 16:32:24 -0000
Date:   Fri, 6 Oct 2023 11:32:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Paul Burton <paulburton@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mips@vger.kernel.org,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 04/11] dt-bindings: Add vendor prefix for Mobileye Vision
 Technologies Ltd.
Message-ID: <169660994413.4040194.1023410875399068071.robh@kernel.org>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-5-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004161038.2818327-5-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Oct 2023 18:10:31 +0200, Gregory CLEMENT wrote:
> Mobileye Vision Technologies Ltd. is a company developing autonomous
> driving technologies and advanced driver-assistance systems (ADAS)
> including cameras, computer chips and software.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

