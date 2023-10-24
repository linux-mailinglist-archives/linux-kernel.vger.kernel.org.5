Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E87D486E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjJXHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjJXHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D171AA6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42933C433C7;
        Tue, 24 Oct 2023 07:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698132243;
        bh=z+98ZYYA5tYAXrUA29VmteMZJ1HAPVT8QigkmFc0UAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHgzh0+aZBqtNEQGXgQvoZnqi8f2xzj0q58L0tywtJF5wveM9y4mph3y8c3kI7Xal
         9R86deghjK+J5NrK0ExKGGI9dXDScOEpFuyWey5ObyFDVUEyxaTg6gy6bR02z+MbF0
         jBReElzu3uzsCaGT0JKB8Dcway7xnuvbszKCsZ+PeN7Gnd+ApFDX+fTXlu4h18CGId
         Mk6H+TTfCNeKGKpTRe+hK7W1JPRmSze7ggKl2SRQWlwMJ67/5MMk1KNqtT4Jb6GB5e
         SW+aVDPEHQ7y4s484NpHn90rqAowBiu6vXiJ/hrcnDvHYq3GvP3FPfHc65m8PwqeYx
         cwUORK9JOk4Fg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvBm0-0003ib-06;
        Tue, 24 Oct 2023 09:24:20 +0200
Date:   Tue, 24 Oct 2023 09:24:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Message-ID: <ZTdxJKFSfeSHoHXN@hovoldconsulting.com>
References: <TYZPR02MB508845BAD7936A62A105CE5D89DFA@TYZPR02MB5088.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR02MB508845BAD7936A62A105CE5D89DFA@TYZPR02MB5088.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 06:36:58AM +0000, Puliang Lu(Puliang) wrote:
> On Mon, 16 Oct 2023 10:40:05 +0200, Johan Hovold wrote:

> > I've now applied the patch.
> 
> Can I still modify my patch now? 0x8213 is an ESIM device, 0x8215 is a NO ESIM 
> device, but it is written backwards in the commit message, and the define is 
> also reversed.

No, this patch is already in Linus's tree so that's not possible. But
please do send a follow-up incremental fix.

Johan
