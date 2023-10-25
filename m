Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1A7D6F91
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbjJYOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344982AbjJYOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:25:37 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 799D818A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:25:29 -0700 (PDT)
Received: (qmail 495360 invoked by uid 1000); 25 Oct 2023 10:25:28 -0400
Date:   Wed, 25 Oct 2023 10:25:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: add shutdown function for usb storage
 driver
Message-ID: <f6dec17d-471c-4bec-b730-1a4bbfbf21e7@rowland.harvard.edu>
References: <20231023054111.2744872-1-Meng.Li@windriver.com>
 <33bd0779-bfe7-4c87-8fe6-ea8455df3b6b@rowland.harvard.edu>
 <PH0PR11MB51918DD50651DB6BE937BEA3F1DFA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <3fe5b43c-a5aa-4c6a-8614-03a4d9dd53e2@rowland.harvard.edu>
 <2023102428-zit-quickness-9b73@gregkh>
 <5107f6ca-e972-4af1-a21d-6c95778969f3@rowland.harvard.edu>
 <2023102459-protector-frequency-1033@gregkh>
 <a6bb88cd-0b89-4eb1-b90d-8ad633b7a8f2@rowland.harvard.edu>
 <CO1PR11MB5188998FE62B30C3CA83A6F8F1DEA@CO1PR11MB5188.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5188998FE62B30C3CA83A6F8F1DEA@CO1PR11MB5188.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 02:25:17AM +0000, Li, Meng wrote:
> In fact, the reported error is not critical one. In my real work environment, there is not the error because there is not PCIe-TO-USB card installed on board.
> The issue is reported to me from our tester who used the PCIe-TO-USB card to test the PCIe feature, not test USB feature.
> I am ok to NAK this patch. The primary intention of sending this patch is to raise up the discussion about whether shutdown function should be added for usb mass storage driver, and I have got what I want.

All right, then we will consider the issue closed.  Thanks.

Alan Stern
