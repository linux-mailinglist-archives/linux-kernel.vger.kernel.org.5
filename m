Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871947ADE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjIYR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjIYR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:57:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6979127;
        Mon, 25 Sep 2023 10:57:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530BDC433C7;
        Mon, 25 Sep 2023 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695664629;
        bh=gu84MV14kgINMupwSI+2Lf8n14Xc8CuSlYzvB+lIaAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVAvGwCM5r7G+NXm8onSVszBufuhcKD8cs8bfswFndPYecBF24lr/gTcgW+2Z6PNV
         r6LtkbA3mOh9Ef01ms8jTM17ZqeZYegZlvbS4xeJf8NDjP3JEXzLWTh1B1EfedUMij
         T2/aGCpuZdQN5x5LMDfFNoCImF+o/gBE3BuFvdTpCGv2wGgrGgD5oVHImq+kOr1QsQ
         OQiguAbHlmWisIkMXr7DOoii/ysXJq6bxTpKy3fTXX7pX1tb2++LDakF8M9Qr0OkxG
         +V4hGcOIEkB4kqCE7MZ18iTcF9mkc3bgIg+JIflFnznrvPvTyzTKyG9tI4xtxMfcqf
         wG1JAIH8o43vQ==
Received: (nullmailer pid 1642965 invoked by uid 1000);
        Mon, 25 Sep 2023 17:57:06 -0000
Date:   Mon, 25 Sep 2023 12:57:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: serial: document esp32s3-acm
Message-ID: <169566462582.1642906.11148927426124876101.robh@kernel.org>
References: <20230925084825.4160708-1-jcmvbkbc@gmail.com>
 <20230925084825.4160708-5-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925084825.4160708-5-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 01:48:24 -0700, Max Filippov wrote:
> Add documentation for the ESP32S3 USB CDC-ACM controller.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> 
> ---
> Changes v2->v3:
> - add a reference to serial.yaml
> 
> Changes v1->v2:
> - fix description
> - rename node in the example
> - fix example indentation
> 
>  .../bindings/serial/esp,esp32-acm.yaml        | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

