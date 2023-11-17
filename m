Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4D7EF30C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbjKQMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKQMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:52:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3430D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:52:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E6DC433C8;
        Fri, 17 Nov 2023 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700225544;
        bh=kTLXCm1xShjyUDmWE4xeZjNHPRrRIIppOueUV0RDT2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcSp1QDdxC/MQvr9Ne5zh/HBYwMHao3rWw7w5iZ/62Osy6Yq6N3WmoLOGpl3pmZNH
         ke/c7KKx4raoaT3Vf39v8PsqOAMc5y8vA1sNj/Fpe9tYUSPuWwS94/i02dj37+dK6E
         +n9QP9deZBDRotRAQ+N7pB5QMjqV3LocVqBnf5290nlHxXSW2VHsgNIUEdOzJFJ8XI
         eh04+VdZY6aytWKw8VrCWlXTUV6tkSJca9G8Ol3G0QxEhxAE7R5rmH7nQ/N5PGXOKg
         Mu/H4xZHOM8Qkhq1tx5e8IGTEggnSV7zvOq3YnIEWBeFFaENHiSSi8kjRzpH7CmFNx
         Z98hqHkgAs2wA==
Date:   Fri, 17 Nov 2023 12:52:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH v2 0/2] leds: add more LED color and function definitions
Message-ID: <20231117125219.GB153049@google.com>
References: <TYAP286MB0315D3014B329FE6B5873F76BCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYAP286MB0315D3014B329FE6B5873F76BCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Shiji Yang wrote:

> Hi!
> 
> This series patches add the missing LED color definitions and
> introduces two widely used LED functions "internet" and "rssi".
> 
> Regards,
> Shiji Yang
> 
> 
> Changes in v2:
> * Remove the LED name sorting patch as it changes the ABI
> 
> 
> Shiji Yang (2):
>   leds: core: add missing LED color strings
>   dt-bindings: leds: add "internet" and "rssi" function definitions

I don't see these patches attached to this cover letter.

Did you send them all threaded? 

-- 
Lee Jones [李琼斯]
