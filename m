Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F947EB0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjKNNRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjKNNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:17:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86628196
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:17:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D992BC433C8;
        Tue, 14 Nov 2023 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699967825;
        bh=95s2UhAyv7w3qkWGxOMjyvVxTKgmywcvyhwdCB9sRus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skCpHjl77gyyq3x8ZmKDtmcQ0WaVAtMKkeKcpSd/Wkj3+5+034RBC/OUtMmcwbD5D
         vanenJlaqbnsTeN9t9K3EvtQ4XviPFqNOgKEgn9CrxmLPaaRyX5bXu7cUhybXZWTu4
         MO0yV4Cox/hkGrQQ5YBsFSRhVitsrCfdllerzNl0=
Date:   Tue, 14 Nov 2023 08:17:03 -0500
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] misc: rtsx: add to support new card reader
 rts5264 new  definition and function
Message-ID: <2023111423-unloved-preflight-fc7f@gregkh>
References: <bf45a73f01cc43669dc3796ccff25598@realtek.com>
 <5342711849f545f783d9b0f40f4dd94f@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5342711849f545f783d9b0f40f4dd94f@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 02:27:36AM +0000, Ricky WU wrote:
> Hi Greg k-h and Ulf hansson,
> 
> Can I know what is the status of this patch?

The merge window _just_ ended yesterday, please give us a chance to
catch up with patches and reviews for everything that has been submitted
in the past 2 weeks.

To help that out, please review other changes that have been submitted
for the misc subsystem, which will help move your patches to the top of
the list.

> This new Reader is going on some new product, need this patch to support

The earliest this will end up in a release will be the 6.8 kernel, and
we do not have deadlines for new features, it will be merged when it has
been properly reviewed.

thanks,

greg k-h
