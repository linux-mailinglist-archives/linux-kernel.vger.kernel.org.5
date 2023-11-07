Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810967E369A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjKGI1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA5BD;
        Tue,  7 Nov 2023 00:27:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51023C433C8;
        Tue,  7 Nov 2023 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699345658;
        bh=f5uRiCTOApxfAK7VR7AfAgzcJENju54hdUOwjjDL6gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMrebyucQAeTgg/bfZ5ZLCRNTuEbMOark2KmHNLo4bxwGcvBTHNFICjlw8Sogi4Gz
         D/Zg1JQLuKarsxPRyIRU24GFNxogLRJbxcI4h7OGntoRqx7ocHBmc7SQwft1R5CAu9
         Njg8K74u4iOlbLpSydNNLbIhKoS8aTCvc4QH84fg=
Date:   Tue, 7 Nov 2023 09:27:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
Subject: Re: [PATCH v11 0/9] Add StarFive Camera Subsystem driver
Message-ID: <2023110756-alto-stream-eb92@gregkh>
References: <20231025031422.3695-1-jack.zhu@starfivetech.com>
 <15ef0a70-734e-280a-f014-41914a55d8cf@starfivetech.com>
 <a3a2c179-2cbe-5a55-a21e-b45abfb6d494@starfivetech.com>
 <2023110745-tableful-trapezoid-4206@gregkh>
 <2023110730-thousand-skyrocket-d6ba@gregkh>
 <a2dbb182-2573-4c86-7e18-319d26a6593c@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2dbb182-2573-4c86-7e18-319d26a6593c@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 04:05:11PM +0800, Jack Zhu wrote:
> > Also, while you wait, why not just finish off the last 3 items on the
> > TODO list which would make your code not be required to go into the
> > staging portion of the tree at all?  You've had a few weeks now, what is
> > preventing that from happening, and when will that work actually be
> > done?
> > 
> 
> One of my colleagues is doing related development, but he also has other
> projects at the same time, so he cannot devote all his efforts to this
> development. And we expect to use libcamera, which may take some time.

So that means there is no real plan at all to get this out of the
staging directory?  If so, why should we take it at all as obviously
this means that the code is now abandoned?

confused,

greg k-h
