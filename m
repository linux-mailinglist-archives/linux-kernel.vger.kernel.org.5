Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B862D803B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjLDRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLDRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:07:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8565C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:07:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45055C433C8;
        Mon,  4 Dec 2023 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701709641;
        bh=mt093VTtGq5Qlwj3G6OkmJBdRwq4g/+zIdsd0yfDcVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hd0/CdtoomeVktSiDKrquMd+1bXGk8Lh0U3TYWfKkoeT7YUk8l2ufEwRmLop522Te
         QQhUZZNcQ2QcjyrbqOOppuP/r+kTcfIIr4CAaQiHcxAtAOTx/XWFmvTnb8bNlTrJe3
         3ur1dxl+VqR6ZxNM6HBM7CvXQB7MLmR0yV5Cj4LfQCIFEuQyjPGdrWWl2D52b679id
         1EOFiP+0RQc3qfLrfJd35tY/0j187QMo8TZ1mV9fs7xvVBXPC/ZLxfZyZnjH+cVtgy
         oAZ3lUuXLgndjc6Co0437lyD+nbLaRG0WNNfPExMGyzpMCXIA3/bWFr9zkygF0cSPw
         lu7sL8uq6SEqA==
Date:   Mon, 4 Dec 2023 17:07:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Message-ID: <20231204170712.4d100617@jic23-huawei>
In-Reply-To: <20231204-exclude-tapioca-0db6d01640aa@spud>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
        <20231204132624.03733d50@jic23-huawei>
        <20231204-exclude-tapioca-0db6d01640aa@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 16:25:34 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Dec 04, 2023 at 01:26:24PM +0000, Jonathan Cameron wrote:
> > On Thu, 30 Nov 2023 18:16:22 +0100
> > Johan Hovold <johan+linaro@kernel.org> wrote:
> >   
> > > When reviewing the various SPMI PMIC bindings, I noticed that several
> > > examples were incorrect and misleading and could also use some cleanup.
> > > 
> > > This series addresses the iio/adc ones.  
> > 
> > All look fine to me.  Just waiting for the DT folk to have time to take a look.  
> 
> Yah, they all look grand to me.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
Applied.  Thanks,

J
