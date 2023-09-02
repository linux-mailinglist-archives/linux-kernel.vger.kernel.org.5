Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6586879083D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjIBOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIBOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:20:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA14593;
        Sat,  2 Sep 2023 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693664427;
        bh=VaN/dytRrQdGSJIWxxYi4CPLw8Rb6mvSbrXc1sYi+0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kx2IrsvQlxciM92qnZN2HZGpSGLnCdwbPgv5rkgquEc9zAkXv3z6JjjiN4E/33sMP
         p4dcgFL1K9+neHzx3XPyV7npKcxbwgjm7dhAh4r39RKdnPv94GfDEEtEhyrWQ/zw5r
         6tai0RpJ19ePjJwpllHstQtubyAxbR5Ee7G5ysJ0=
Date:   Sat, 2 Sep 2023 16:20:27 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
Message-ID: <55fbc98b-8251-44b3-b5a0-a26d123ac932@t-8ch.de>
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
 <56da4837-cfe3-4234-96f7-e7b67358dcdb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56da4837-cfe3-4234-96f7-e7b67358dcdb@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-02 07:10:24-0700, Guenter Roeck wrote:
> On Sat, Sep 02, 2023 at 09:47:01AM +0200, Thomas Weißschuh wrote:
> > POWER-Z is a series of devices to monitor power characteristics of
> > USB-C connections and display those on a on-device display.
> > Some of the devices, notably KM002C and KM003C, contain an additional
> > port which exposes the measurements via USB.
> > 
> > This is a driver for this monitor port.
> > 
> > It was developed and tested with the KM003C.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Applied to hwmon-next.

Thanks!

Thomas
