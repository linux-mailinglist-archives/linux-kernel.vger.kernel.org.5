Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1EA7C7789
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442614AbjJLUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442529AbjJLUA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8425ECC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137EFC433C7;
        Thu, 12 Oct 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697140825;
        bh=8Ceza1ZDkpR+cTaIVe/nQrwJI2ziN4RgO2pzz0SXZsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rz6sWJJRKoju87QlLNM3OyXCmbrsPnVokgeQV0/3cbTq25Wx24srm7JRBlLC/c5w2
         q1IeZdmbk1qsg1v/cgL7zAbWt+aFhgFN3I1vamG8MPR8HAaorN1n1csACsFwlUZtkl
         XbwBoA//zuGdf/vdTigS6auxyAlRVL3aFceJwTNXmTIccRskN3VlT252gK7cGyjHYj
         AKM/uvjr5L63v9oROapYi3GVMyoBkx9S6AlUvg/2zsU9qEHe3Avzoq00FcOnSmToVN
         lJjJgt3EXdfpjTxg5cRjpQboLJFzP+Bz0cVTAk6SRsUUhORBtc32Ln3H4pPkFUPErw
         X2Nc+tkoIjp4Q==
Received: (nullmailer pid 1587847 invoked by uid 1000);
        Thu, 12 Oct 2023 20:00:23 -0000
Date:   Thu, 12 Oct 2023 15:00:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: mfd: rk806: Allow
 system-power-controller property
Message-ID: <169714082258.1587798.5080334695883658494.robh@kernel.org>
References: <20231010174138.1888396-1-megi@xff.cz>
 <20231010174138.1888396-3-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010174138.1888396-3-megi@xff.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023 19:41:17 +0200, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Declare support for this property.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

