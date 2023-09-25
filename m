Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA817ADD63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjIYQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:48:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077199F;
        Mon, 25 Sep 2023 09:48:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A93C433C7;
        Mon, 25 Sep 2023 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695660484;
        bh=wBWKMKBUI+Tl4EZBh+b126NH8pUhWxb26K1nSRFw1oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQfuy/a9Wj3IAzwDSQphRJXNp/8LoT0aM+9+2BvxMeDI3VFeJVXb9caEp9yT5mGzW
         ZfY3HDy02lWkqJ1YEvXK9q43eQEWe/kQUhdZayjNZ/tzKfjEfL8c2wGd4CEtykXmFF
         d+JveidUWQwTRA0Sz/dKNCDHD9xyuTzjJd0X5SpR5J2Gxxot7BnRGitzuvcJINMnu4
         sabH2oL7xQI560riOvpF2NyarmhevHczCu9SgyyJWfoAHDw2PY8ACnb6TGJt73NMUZ
         kt7RRDeehS7g7EYmXIzt9APpUdcGWth4CU/hR0BdnSSmyay9pzS0h75wYrLhsuOFD4
         I3VI14zla3IkA==
Received: (nullmailer pid 1494825 invoked by uid 1000);
        Mon, 25 Sep 2023 16:48:01 -0000
Date:   Mon, 25 Sep 2023 11:48:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: serial: document esp32-uart
Message-ID: <169566048115.1494738.1252654770235463635.robh@kernel.org>
References: <20230925084825.4160708-1-jcmvbkbc@gmail.com>
 <20230925084825.4160708-3-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925084825.4160708-3-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 01:48:22 -0700, Max Filippov wrote:
> Add documentation for the ESP32xx UART controllers.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> 
> ---
> Changes v2->v3:
> - add a reference to serial.yaml
> 
> Changes v1->v2:
> - drop '|' from description
> - change 'compatible' property type to enum
> - drop label from the example node
> - fix example indentation
> 
>  .../bindings/serial/esp,esp32-uart.yaml       | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

