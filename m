Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37D7701B8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHDNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHDNeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:34:18 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 679731BF0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:33:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 69164602506E6;
        Fri,  4 Aug 2023 21:33:45 +0800 (CST)
X-MD-Sfrom: dengxiang@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   dengxiang <dengxiang@nfschina.com>
To:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, dengxiang@nfschina.com
Subject: Re: [PATCH] ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.
Date:   Fri,  4 Aug 2023 21:31:36 +0800
Message-Id: <20230804133136.559701-1-dengxiang@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87leer9j73.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch adds a USB quirk for Mythware XA001AU USB interface.
>> 
>> Signed-off-by: dengxiang 

>Thanks, applied now.

Ok, Thank you very much.
