Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD26A78074D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358670AbjHRIij convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358653AbjHRIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:38:19 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539E30F3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:38:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE5751BF205
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:38:16 +0000 (UTC)
Message-ID: <1e0a825cdacb2cbb1534516c64e08c649e4596bd.camel@gnu-log.net>
Subject: dm-raid usage setup
From:   Benoit Gschwind <gschwind@gnu-log.net>
To:     linux-kernel@vger.kernel.org
Date:   Fri, 18 Aug 2023 10:38:15 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-GND-Sasl: gschwind@gnu-log.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is it fine and sane to stack raid device using dm-raid, i.e. raid-0
above raid-6 ?

Is it fine and sane to use raid-0 for the raid-6 journal ?

Is it fine and sane to use same disks into several different raid, i.e.
splitting disk into two or more partitions and using this partitions as
disk for different raid ?

Thanks by advance
