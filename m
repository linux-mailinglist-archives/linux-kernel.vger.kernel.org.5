Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76780751293
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjGLVW0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLVWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:22:25 -0400
Received: from nicole.computer-surgery.co.uk (mail.computer-surgery.co.uk [82.69.253.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A0CF;
        Wed, 12 Jul 2023 14:22:23 -0700 (PDT)
Received: from [10.94.89.22]
        by nicole.computer-surgery.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rgammans@gammascience.co.uk>)
        id 1qJhHw-0001hN-Aj; Wed, 12 Jul 2023 22:22:20 +0100
Message-ID: <f2d782db43c8f9f78e762af1275618fe55b8b5e7.camel@gammascience.co.uk>
Subject: Re: [PATCH] Bluetooth: btusb: Add support for another MediaTek 7922
 VID/PID
From:   Roger Gammans <rgammans@gammascience.co.uk>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jul 2023 22:22:09 +0100
In-Reply-To: <CABBYNZ+=d28pi8sqnngDGNSuPTyEF1s8XYOzWFSkpTHGQKeinA@mail.gmail.com>
References: <20230711175743.20606-1-rgammans@gammascience.co.uk>
         <CABBYNZ+=d28pi8sqnngDGNSuPTyEF1s8XYOzWFSkpTHGQKeinA@mail.gmail.com>
Organization: Gamma Science Ltd. Reg No: 07356014
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 14:08 -0700, Luiz Augusto von Dentz wrote:
> Hi Roger,
> 
> Please add the information from /sys/kernel/debug/usb/devices.

No problem. V2 inbound shortly.

-- 
Roger Gammans <rgammans@gammascience.co.uk>

