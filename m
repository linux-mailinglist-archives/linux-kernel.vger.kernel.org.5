Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5B7D7CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbjJZGqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjJZGqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:46:35 -0400
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EF193
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:46:32 -0700 (PDT)
Date:   Thu, 26 Oct 2023 08:46:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698302790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8C+xtJB+rzkNqqM7GtaAxsetXtnvMscEnnd5dof4DLo=;
        b=veBmziUiO7Z/w7gkmNkCcic8j0ag0eMKAT4L6zsVXup72KG630NC9cxpw7CuL8LH1XdeNV
        nTzd6XEyTaoLTqRiYsjYfUSuV1exvgtmR51TU2i1ej4pSntKGO5CnPnnONPQx6+BfvC8EO
        FNJoArraraD2HTSg8SqzqrPKoeC+zy0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] MAINTAINERS: Add entry for ina238 driver
Message-ID: <bu4hgxdak4tdtivqfmusaxqcfs3t4e7lzqj6adetela7446bf7@uilfgew3hrmj>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
 <20231025-ina237-v1-1-a0196119720c@linux.dev>
 <f5d92f5b-dc78-4227-b556-2617ef239496@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d92f5b-dc78-4227-b556-2617ef239496@roeck-us.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 06:03:23PM -0700, Guenter Roeck wrote:
> On Wed, Oct 25, 2023 at 10:34:11AM +0000, Richard Leitner wrote:
> > The ina238 driver is available since 2021 but lacks a MAINTAINERS entry
> > file. Therefore add the missing entry now.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> 
> NACK. I am already the hwmon maintainer, and there is no need
> to list me as maintainer for every hwmon driver.

Thanks for the feedback. Understood. Will remove the entry in v2.

regards;rl

> 
> Guenter
> 
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 668d1e24452d..28f91c8a2e1c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10267,6 +10267,12 @@ F:	Documentation/hwmon/ina2xx.rst
> >  F:	drivers/hwmon/ina2xx.c
> >  F:	include/linux/platform_data/ina2xx.h
> >  
> > +INA238 HARDWARE MONITOR DRIVER
> > +M:	Guenter Roeck <linux@roeck-us.net>
> > +L:	linux-hwmon@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/hwmon/ina238.c
> > +
> >  INDEX OF FURTHER KERNEL DOCUMENTATION
> >  M:	Carlos Bilbao <carlos.bilbao@amd.com>
> >  S:	Maintained
