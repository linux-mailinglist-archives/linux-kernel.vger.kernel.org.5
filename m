Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2B7931CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbjIEWGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:06:36 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16611E6;
        Tue,  5 Sep 2023 15:06:30 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C5BAF86543;
        Wed,  6 Sep 2023 00:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693951582;
        bh=KSYPX9ZZMGT/6uNJc7MPL0OTCQ8OVTEsL/MtqUU+ueE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkGobUQLI3BwUXa+Lohf3G2t+B6wxrK6EXu1ddszxnlceON5RPStjLOkhzx2Rz3GC
         YmT0BLn3doHu+CV6aDNgYemJxyOm4W4tWdWNc6v2OqD5U6HO9bYiogOkPGKDj7kWWz
         XYcXXsW9axUrlxtocFKKsERiHsWcRjNl6ttRK2U+bCCthLa7AKS2CvCxkQ/A5cLL+m
         RxAk4KOWjWFeqTB8hqOkDxKLJuVR49cr6bIdUbqey5EpK0mG0ppMr/7qM6tDIlDXrZ
         jKeFLaExjjMZ3djPgaP6w6SshR+KxXlQDcbk2UxMTBdeCAUFxwZ76bDeI8mRnXwgyK
         KfQP75/j1ASCg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Sep 2023 19:06:22 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Fabio Estevam <festevam@gmail.com>, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: rtc: pcf8523: Convert to YAML
In-Reply-To: <08130247-1ccb-1233-3feb-a60e6c0b3610@wolfvision.net>
References: <20230905202827.67212-1-festevam@gmail.com>
 <08130247-1ccb-1233-3feb-a60e6c0b3610@wolfvision.net>
Message-ID: <d699c0d642008bfdd97cee467182560d@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On 05/09/2023 19:03, Javier Carrasco wrote:

> isn't the default value 12500 anymore? it used to be and the driver
> still uses 12500fF as the default value.

You are right.

I will fix it in v3.

Thanks,

Fabio Estevam
