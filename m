Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FF7D0987
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376409AbjJTH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJTH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:28:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D391;
        Fri, 20 Oct 2023 00:28:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0211BC433C8;
        Fri, 20 Oct 2023 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697786894;
        bh=pCCRFM6ULLJjJgsKJt88LvxEULDKIIK3FvHjUIHnSc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dlsvu9S3x6wi/7WivOmOL46rm+tfs6G+zMYeJjQS1Bxw4TklRQL4+Bdfo3hZOppxX
         ZqwuDMJ+PA4AktiscfQyh0RArgy+w/1vPguWKFcG2hLbTsVRhl9k+U54tPzHdAQfsM
         NcmB26PbK2zLpIuTW9i5gvvAcIq/5t7Qs5TkjCYYZJp4lRxpCu17LTXBMRLbEz8LLQ
         /Cbp2TNmqo7DL+x6g+p8r1nSUhtCUmgmGXlv7dE5oeStP8TAfNa/wBuwgIi87dm3KG
         XmWPGqB4Ff+yuMJjhS2ETfBw5dAPNbFVmtiLH64mM+CY/1xODvBI7Vh5GrcP9spIoh
         PtBXPqygSjDTw==
Date:   Fri, 20 Oct 2023 08:28:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Conor Dooley <conor@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, matt@ranostay.org
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Message-ID: <20231020082804.5ee8364a@jic23-huawei>
In-Reply-To: <20231019122120.00007cdd@Huawei.com>
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
        <20231019-rematch-ethically-9d482ca4607e@spud>
        <20231019-theme-clunky-f4a2e1d122e7@spud>
        <0084ddad-d6fc-ca26-2d26-ba71e81f5f8b@tweaklogic.com>
        <20231019122120.00007cdd@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 12:21:20 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 19 Oct 2023 21:24:09 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
> > > Also:
> > > <matt.ranostay@konsulko.com>: host aspmx.l.google.com said:
> > >      550-5.1.1 The email account that you tried to reach does not exist.    
> > Thanks Conor for pointing this out. Can you please help me out with this?
> > get_maintainer.pl suggested me to add this email ID.  
> 
> Matt has moved job, I've messaged him to find out if he has a new preferred
> email address.
>
+CC address Matt suggested using going forwards.
 
> J
> > 
> > Regards,
> > Subhajit Ghosh
> >   
> 

