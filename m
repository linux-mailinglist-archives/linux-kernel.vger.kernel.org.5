Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E430E7F8DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjKYTTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:19:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA18115
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:19:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDACAC433C7;
        Sat, 25 Nov 2023 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700939961;
        bh=GSU+FQRZrnLS3wf0M1GAvOKYYsp/Eq3r/A9qs73Dwvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DzIp3k/qV7o+Yci5AaeXOAzy6V5srN90uVnRBk0J9EPN/qoMx8iKdo9uLHFCZdfzF
         pZmevphryCb7ysXJzmV1MuVGKxVwgi7dCqprLh0x38SnZC3ZsYvo+oUPmTThO8DssB
         hHlV9G5iniaJ5P924uWSMcLMywJ09QasewtbbjTu+NmUCQxeL3paog1CLnX0wNRGTR
         nx1/bYwOgti//b2v++US11X3wMe9Qb7YRrUhUvQOz0VdCYZJKJmcf4bsU43UUB+WFD
         tg4EpOii8MvPas4rjjlf/Eo/qgjlnZ11DPBzE5x8C1JsH66IG1i0D/INPRhmjioiUD
         3kve4Aw1DGapQ==
Date:   Sat, 25 Nov 2023 19:19:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <20231125191915.7f1f2dc4@jic23-huawei>
In-Reply-To: <20231117192305.17612-1-petre.rodan@subdimension.ro>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
        <20231117192305.17612-1-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 21:22:57 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Adds binding for digital Honeywell TruStability HSC and SSC series pressure 
> and temperature sensors.
> 
> Datasheet:
>  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
>  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Hi Petre,

Please resend whole series when you do a new version.  I know that some
areas of the kernel do minor tweaks by reply to an earlier version but
in IIO we rely heavily on patchwork for tracking and it makes it very
hard to find the email.

Also, don't make that a reply to earlier version. The nesting of
remotely complex threads makes that impossible track once we have
a few versions posted.

Jonathan
