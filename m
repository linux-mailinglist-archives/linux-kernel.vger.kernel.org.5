Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B877C2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjHNVqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjHNVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:45:43 -0400
Received: from out-110.mta1.migadu.com (out-110.mta1.migadu.com [IPv6:2001:41d0:203:375::6e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DAF110
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:45:40 -0700 (PDT)
Date:   Tue, 15 Aug 2023 07:44:09 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1692049538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z5vMIw8DJMsrloH2u0r4CfAufO0NQJmDEE/VNvMeWT8=;
        b=JSl24lyiL62b32aQBcJyKIwpfARIEA7P/At0FHiQtsneU8Lr5NeVTQrAUbdw/4Uxdb99bS
        bF0szz1Z/4Jh7n9II9AAUPZvsdEcBhjgYBIWSy8u9GwBSOz9Cvf6FgmRE9gMpLi0Af7dE1
        E/7JPGtvJY2Vv2FYvDKFgDCZ9P9psgjF4lbjERxr74jkZGMTt0cosEASDHb35sqH+QN+iG
        sfRfl2i8xHwBOwuTFcNbOAv7zH5BYkDTLt2btYuzLtXJNXINmipegA9z7IQVTseAQohGjH
        XrWkT0DiExUaP0euM7pGc1KtVZJIzlwBHdTycKUID5Z4Nzi07l+EPq8srAoB8w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: wlf,wm8782: Add max-rate property
Message-ID: <ZNqgKW3TZBVF8ggo@titan>
References: <20230810224930.3216717-1-contact@jookia.org>
 <20230810224930.3216717-4-contact@jookia.org>
 <ZNY+x/R8/T5ysPhy@finisterre.sirena.org.uk>
 <ZNZFB2-kBrpnMSn1@titan>
 <a7db4653-cb12-4f90-891c-5cf7270598bd@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7db4653-cb12-4f90-891c-5cf7270598bd@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:27:04PM +0100, Mark Brown wrote:
> You'd have to define an enum for that but it does still feel like it
> might be easier to work with since it's more direct.

Alright, I'll give it a go in the next version. Thanks for the feedback!

John.
