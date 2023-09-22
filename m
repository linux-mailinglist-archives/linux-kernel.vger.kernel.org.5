Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69A7ABBF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjIVWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIVWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:44:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F19E8;
        Fri, 22 Sep 2023 15:44:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5137C433C8;
        Fri, 22 Sep 2023 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695422642;
        bh=53Onsy+ZW7rqbwjy97PFrpjs6d8nYu1/Bx+wXNJCqaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0qdJ2paJC4V57QqnfkIKfUKqVenLouKnVUTsVUib0hWtbyYjMiRrXD23ghIBS+2v
         0X130XtcgWgnkYvH5bzasknC2dgqf4v9yjHbB8+/NWA0n/8A0xaxaYOcfempMvO+Z0
         f9JVPBOICU7uFRvfnR2dToF0Ikfphv2+i7vrhjUAJIAnWJvrz42OQYVCEoRAalOIKb
         t1hlJCA1k6vwQbmZEZEV858VD1IaL3rtm/PVHxz9dPqYbLISpTMqGYVX38/o/4KviT
         X4rNHWcqeaGOnfGQKoUYvgCiiRkRrvA+CEOidOkHfRlPY5RwFtsdmCAumVTMlboZXR
         VMd4vzRoC+4DA==
Received: (nullmailer pid 4068089 invoked by uid 1000);
        Fri, 22 Sep 2023 22:44:00 -0000
Date:   Fri, 22 Sep 2023 17:44:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Philip Molloy <pmolloy@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Apelete Seketeli <aseketeli@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 01/19] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Message-ID: <169542264006.4068010.15737012962684747566.robh@kernel.org>
References: <20230921144400.62380-1-dlechner@baylibre.com>
 <20230921144400.62380-2-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921144400.62380-2-dlechner@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Sep 2023 09:43:42 -0500, David Lechner wrote:
> This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
> resolver-to-digital converter.
> 
> Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v2 changes:
> * Add Co-developed-by:
> * Remove extraneous quotes on strings
> * Remove extraneous pipe on some multi-line descriptions
> 
>  .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

