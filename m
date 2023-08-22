Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5424478380A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjHVCif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjHVCi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81398187
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1653961D27
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF83C433C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:38:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYHI1-001bYf-0k
        for linux-kernel@vger.kernel.org;
        Mon, 21 Aug 2023 22:38:41 -0400
Message-ID: <20230822023803.605698724@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Aug 2023 22:38:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,EMPTY_MESSAGE,
        HEADER_FROM_DIFFERENT_DOMAINS,MISSING_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

