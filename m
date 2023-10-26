Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDA7D8A25
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjJZVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:18:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463210E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=exFPRb2NAEfbehhlj1MSOPGcRjloc+uCU+k7TGHLYZA=; b=yUF4FhncQUZzsWYnCF14yrzUER
        KfyqHRK3KLKLO7J9tO5337B06VcVJyw/pMg5ZBKSIHfa2BHrxw/2nbf7S8X4W/leZc1o1oP2POOID
        G80I2qlZ/HMhBg6FTSCPI1bYg6eGGS3B5rVFGgQEpODNsRTw7b9xKUj/1K9o3ShjyhI+WAawK9fEY
        eOzL/Q0U6DHAjSvO8z/KHt+LKmu4HCnB1lPuIapWkIIYra+mixWZ1IUdNQ+GIrEMNoKO3GncJdDuG
        yOPlzNuJ8stZEqdeqVSGuaeon+7NI+heajCJxaNjs4IGWtqjwfju/ZZ78b6Zizh0jEgD5yuOLNp6o
        /vl1ro2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qw7jt-00FAKJ-1b;
        Thu, 26 Oct 2023 21:18:01 +0000
Date:   Thu, 26 Oct 2023 14:18:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] firmware_loader: Refactor
 kill_pending_fw_fallback_reqs()
Message-ID: <ZTrXiYngcJ9wWoiU@bombadil.infradead.org>
References: <1698330459-31776-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698330459-31776-1-git-send-email-quic_mojha@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:57:38PM +0530, Mukesh Ojha wrote:
> Rename 'only_kill_custom' and refactor logic related to it
> to be more meaningful.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
