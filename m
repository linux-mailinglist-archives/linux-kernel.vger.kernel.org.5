Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C88805DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjLESVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346672AbjLESVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:21:31 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D6BB9C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:21:37 -0800 (PST)
Received: (qmail 425651 invoked by uid 1000); 5 Dec 2023 13:21:37 -0500
Date:   Tue, 5 Dec 2023 13:21:37 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, tj@kernel.org, paulmck@kernel.org,
        Martin.Mueller5@de.bosch.com
Subject: Re: [PATCH 1/2] usb: hub: Replace hardcoded quirk value with BIT()
 macro
Message-ID: <6071af53-e3a0-4394-a51b-81db562d0940@rowland.harvard.edu>
References: <20231205181829.127353-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205181829.127353-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 07:18:28PM +0100, Hardik Gajjar wrote:
> This patch replaces the hardcoded quirk value in the macro with
> BIT().
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
