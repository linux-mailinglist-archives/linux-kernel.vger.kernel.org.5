Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3767CA041
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjJPHOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjJPHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:14:04 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA7D9;
        Mon, 16 Oct 2023 00:13:51 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=966793e2c5=fe@dev.tdt.de>)
        id 1qsHnH-00A6Jb-Qn; Mon, 16 Oct 2023 09:13:39 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qsHnG-00A6J6-Vn; Mon, 16 Oct 2023 09:13:39 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 8F197240052;
        Mon, 16 Oct 2023 09:13:38 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id DE170240050;
        Mon, 16 Oct 2023 09:13:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 2D2C72BE05;
        Mon, 16 Oct 2023 09:13:37 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 1/4] tty: whitespaces in descriptions corrected by replacing tabs with spaces.
Date:   Mon, 16 Oct 2023 09:13:29 +0200
Message-ID: <20231016071332.597654-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231016071332.597654-1-fe@dev.tdt.de>
References: <20231016071332.597654-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1697440419-9DBC47EA-CB5623A2/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tabs were used in the function description, to make this look more
uniform, the tabs were replaced by spaces where necessary.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/tty/tty_io.c | 102 +++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..3299a5d50727 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -159,7 +159,7 @@ static int tty_fasync(int fd, struct file *filp, int =
on);
 static void release_tty(struct tty_struct *tty, int idx);
=20
 /**
- * free_tty_struct	-	free a disused tty
+ * free_tty_struct - free a disused tty
  * @tty: tty struct to free
  *
  * Free the write buffers, tty queue and tty memory itself.
@@ -233,7 +233,7 @@ static void tty_del_file(struct file *file)
 }
=20
 /**
- * tty_name	-	return tty naming
+ * tty_name - return tty naming
  * @tty: tty structure
  *
  * Convert a tty structure into a name. The name reflects the kernel nam=
ing
@@ -295,7 +295,7 @@ static void check_tty_count(struct tty_struct *tty, c=
onst char *routine)
 }
=20
 /**
- * get_tty_driver		-	find device of a tty
+ * get_tty_driver - find device of a tty
  * @device: device identifier
  * @index: returns the index of the tty
  *
@@ -320,7 +320,7 @@ static struct tty_driver *get_tty_driver(dev_t device=
, int *index)
 }
=20
 /**
- * tty_dev_name_to_number	-	return dev_t for device name
+ * tty_dev_name_to_number - return dev_t for device name
  * @name: user space name of device under /dev
  * @number: pointer to dev_t that this function will populate
  *
@@ -372,7 +372,7 @@ EXPORT_SYMBOL_GPL(tty_dev_name_to_number);
 #ifdef CONFIG_CONSOLE_POLL
=20
 /**
- * tty_find_polling_driver	-	find device of a polled tty
+ * tty_find_polling_driver - find device of a polled tty
  * @name: name string to match
  * @line: pointer to resulting tty line nr
  *
@@ -505,7 +505,7 @@ static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
=20
 /**
- * tty_wakeup	-	request more data
+ * tty_wakeup - request more data
  * @tty: terminal
  *
  * Internal and external helper for wakeups of tty. This function inform=
s the
@@ -529,7 +529,7 @@ void tty_wakeup(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_wakeup);
=20
 /**
- * tty_release_redirect	-	Release a redirect on a pty if present
+ * tty_release_redirect - Release a redirect on a pty if present
  * @tty: tty device
  *
  * This is available to the pty code so if the master closes, if the sla=
ve is a
@@ -550,7 +550,7 @@ static struct file *tty_release_redirect(struct tty_s=
truct *tty)
 }
=20
 /**
- * __tty_hangup		-	actual handler for hangup events
+ * __tty_hangup - actual handler for hangup events
  * @tty: tty device
  * @exit_session: if non-zero, signal all foreground group processes
  *
@@ -673,7 +673,7 @@ static void do_tty_hangup(struct work_struct *work)
 }
=20
 /**
- * tty_hangup		-	trigger a hangup event
+ * tty_hangup - trigger a hangup event
  * @tty: tty to hangup
  *
  * A carrier loss (virtual or otherwise) has occurred on @tty. Schedule =
a
@@ -687,7 +687,7 @@ void tty_hangup(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_hangup);
=20
 /**
- * tty_vhangup		-	process vhangup
+ * tty_vhangup - process vhangup
  * @tty: tty to hangup
  *
  * The user has asked via system call for the terminal to be hung up. We=
 do
@@ -703,7 +703,7 @@ EXPORT_SYMBOL(tty_vhangup);
=20
=20
 /**
- * tty_vhangup_self	-	process vhangup for own ctty
+ * tty_vhangup_self - process vhangup for own ctty
  *
  * Perform a vhangup on the current controlling tty
  */
@@ -719,7 +719,7 @@ void tty_vhangup_self(void)
 }
=20
 /**
- * tty_vhangup_session	-	hangup session leader exit
+ * tty_vhangup_session - hangup session leader exit
  * @tty: tty to hangup
  *
  * The session leader is exiting and hanging up its controlling terminal=
.
@@ -735,7 +735,7 @@ void tty_vhangup_session(struct tty_struct *tty)
 }
=20
 /**
- * tty_hung_up_p	-	was tty hung up
+ * tty_hung_up_p - was tty hung up
  * @filp: file pointer of tty
  *
  * Return: true if the tty has been subject to a vhangup or a carrier lo=
ss
@@ -756,7 +756,7 @@ void __stop_tty(struct tty_struct *tty)
 }
=20
 /**
- * stop_tty	-	propagate flow control
+ * stop_tty - propagate flow control
  * @tty: tty to stop
  *
  * Perform flow control to the driver. May be called on an already stopp=
ed
@@ -790,7 +790,7 @@ void __start_tty(struct tty_struct *tty)
 }
=20
 /**
- * start_tty	-	propagate flow control
+ * start_tty - propagate flow control
  * @tty: tty to start
  *
  * Start a tty that has been stopped if at all possible. If @tty was pre=
viously
@@ -898,7 +898,7 @@ static ssize_t iterate_tty_read(struct tty_ldisc *ld,=
 struct tty_struct *tty,
=20
=20
 /**
- * tty_read	-	read method for tty device files
+ * tty_read - read method for tty device files
  * @iocb: kernel I/O control block
  * @to: destination for the data read
  *
@@ -1091,7 +1091,7 @@ static ssize_t file_tty_write(struct file *file, st=
ruct kiocb *iocb, struct iov_
 }
=20
 /**
- * tty_write		-	write method for tty device file
+ * tty_write - write method for tty device file
  * @iocb: kernel I/O control block
  * @from: iov_iter with data to write
  *
@@ -1133,7 +1133,7 @@ ssize_t redirected_tty_write(struct kiocb *iocb, st=
ruct iov_iter *iter)
 }
=20
 /**
- * tty_send_xchar	-	send priority character
+ * tty_send_xchar - send priority character
  * @tty: the tty to send to
  * @ch: xchar to send
  *
@@ -1167,7 +1167,7 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 }
=20
 /**
- * pty_line_name	-	generate name for a pty
+ * pty_line_name - generate name for a pty
  * @driver: the tty driver in use
  * @index: the minor number
  * @p: output buffer of at least 6 bytes
@@ -1188,7 +1188,7 @@ static void pty_line_name(struct tty_driver *driver=
, int index, char *p)
 }
=20
 /**
- * tty_line_name	-	generate name for a tty
+ * tty_line_name - generate name for a tty
  * @driver: the tty driver in use
  * @index: the minor number
  * @p: output buffer of at least 7 bytes
@@ -1239,7 +1239,7 @@ static struct tty_struct *tty_driver_lookup_tty(str=
uct tty_driver *driver,
 }
=20
 /**
- * tty_init_termios	-  helper for termios setup
+ * tty_init_termios - helper for termios setup
  * @tty: the tty to set up
  *
  * Initialise the termios structure for this tty. This runs under the
@@ -1322,7 +1322,7 @@ static void tty_driver_remove_tty(struct tty_driver=
 *driver, struct tty_struct *
 }
=20
 /**
- * tty_reopen()	- fast re-open of an open tty
+ * tty_reopen() - fast re-open of an open tty
  * @tty: the tty to open
  *
  * Re-opens on master ptys are not allowed and return -%EIO.
@@ -1366,7 +1366,7 @@ static int tty_reopen(struct tty_struct *tty)
 }
=20
 /**
- * tty_init_dev		-	initialise a tty device
+ * tty_init_dev - initialise a tty device
  * @driver: tty driver we are opening a device on
  * @idx: device index
  *
@@ -1488,7 +1488,7 @@ void tty_save_termios(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_save_termios);
=20
 /**
- * tty_flush_works	-	flush all works of a tty/pty pair
+ * tty_flush_works - flush all works of a tty/pty pair
  * @tty: tty device to flush works for (or either end of a pty pair)
  *
  * Sync flush all works belonging to @tty (and the 'other' tty).
@@ -1504,7 +1504,7 @@ static void tty_flush_works(struct tty_struct *tty)
 }
=20
 /**
- * release_one_tty	-	release tty structure memory
+ * release_one_tty - release tty structure memory
  * @work: work of tty we are obliterating
  *
  * Releases memory associated with a tty structure, and clears out the
@@ -1552,7 +1552,7 @@ static void queue_release_one_tty(struct kref *kref=
)
 }
=20
 /**
- * tty_kref_put		-	release a tty kref
+ * tty_kref_put - release a tty kref
  * @tty: tty device
  *
  * Release a reference to the @tty device and if need be let the kref la=
yer
@@ -1566,7 +1566,7 @@ void tty_kref_put(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_kref_put);
=20
 /**
- * release_tty		-	release tty structure memory
+ * release_tty - release tty structure memory
  * @tty: tty device release
  * @idx: index of the tty device release
  *
@@ -1643,7 +1643,7 @@ static int tty_release_checks(struct tty_struct *tt=
y, int idx)
 }
=20
 /**
- * tty_kclose      -       closes tty opened by tty_kopen
+ * tty_kclose - closes tty opened by tty_kopen
  * @tty: tty device
  *
  * Performs the final steps to release and free a tty device. It is the =
same as
@@ -1673,7 +1673,7 @@ void tty_kclose(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_kclose);
=20
 /**
- * tty_release_struct	-	release a tty struct
+ * tty_release_struct - release a tty struct
  * @tty: tty device
  * @idx: index of the tty
  *
@@ -1702,7 +1702,7 @@ void tty_release_struct(struct tty_struct *tty, int=
 idx)
 EXPORT_SYMBOL_GPL(tty_release_struct);
=20
 /**
- * tty_release		-	vfs callback for close
+ * tty_release - vfs callback for close
  * @inode: inode of tty
  * @filp: file pointer for handle to tty
  *
@@ -1983,7 +1983,7 @@ static struct tty_struct *tty_kopen(dev_t device, i=
nt shared)
 }
=20
 /**
- * tty_kopen_exclusive	-	open a tty device for kernel
+ * tty_kopen_exclusive - open a tty device for kernel
  * @device: dev_t of device to open
  *
  * Opens tty exclusively for kernel. Performs the driver lookup, makes s=
ure
@@ -2003,7 +2003,7 @@ struct tty_struct *tty_kopen_exclusive(dev_t device=
)
 EXPORT_SYMBOL_GPL(tty_kopen_exclusive);
=20
 /**
- * tty_kopen_shared	-	open a tty device for shared in-kernel use
+ * tty_kopen_shared - open a tty device for shared in-kernel use
  * @device: dev_t of device to open
  *
  * Opens an already existing tty for in-kernel use. Compared to
@@ -2018,7 +2018,7 @@ struct tty_struct *tty_kopen_shared(dev_t device)
 EXPORT_SYMBOL_GPL(tty_kopen_shared);
=20
 /**
- * tty_open_by_driver	-	open a tty device
+ * tty_open_by_driver - open a tty device
  * @device: dev_t of device to open
  * @filp: file pointer to tty
  *
@@ -2086,7 +2086,7 @@ static struct tty_struct *tty_open_by_driver(dev_t =
device,
 }
=20
 /**
- * tty_open	-	open a tty device
+ * tty_open - open a tty device
  * @inode: inode of device file
  * @filp: file pointer to tty
  *
@@ -2180,7 +2180,7 @@ static int tty_open(struct inode *inode, struct fil=
e *filp)
=20
=20
 /**
- * tty_poll	-	check tty status
+ * tty_poll - check tty status
  * @filp: file being polled
  * @wait: poll wait structures to update
  *
@@ -2258,7 +2258,7 @@ static int tty_fasync(int fd, struct file *filp, in=
t on)
=20
 static bool tty_legacy_tiocsti __read_mostly =3D IS_ENABLED(CONFIG_LEGAC=
Y_TIOCSTI);
 /**
- * tiocsti		-	fake input character
+ * tiocsti - fake input character
  * @tty: tty to fake input into
  * @p: pointer to character
  *
@@ -2295,7 +2295,7 @@ static int tiocsti(struct tty_struct *tty, char __u=
ser *p)
 }
=20
 /**
- * tiocgwinsz		-	implement window query ioctl
+ * tiocgwinsz - implement window query ioctl
  * @tty: tty
  * @arg: user buffer for result
  *
@@ -2316,7 +2316,7 @@ static int tiocgwinsz(struct tty_struct *tty, struc=
t winsize __user *arg)
 }
=20
 /**
- * tty_do_resize	-	resize event
+ * tty_do_resize - resize event
  * @tty: tty being resized
  * @ws: new dimensions
  *
@@ -2346,7 +2346,7 @@ int tty_do_resize(struct tty_struct *tty, struct wi=
nsize *ws)
 EXPORT_SYMBOL(tty_do_resize);
=20
 /**
- * tiocswinsz		-	implement window size set ioctl
+ * tiocswinsz - implement window size set ioctl
  * @tty: tty side of tty
  * @arg: user buffer for result
  *
@@ -2373,7 +2373,7 @@ static int tiocswinsz(struct tty_struct *tty, struc=
t winsize __user *arg)
 }
=20
 /**
- * tioccons	-	allow admin to move logical console
+ * tioccons - allow admin to move logical console
  * @file: the file to become console
  *
  * Allow the administrator to move the redirected console device.
@@ -2412,7 +2412,7 @@ static int tioccons(struct file *file)
 }
=20
 /**
- * tiocsetd	-	set line discipline
+ * tiocsetd - set line discipline
  * @tty: tty device
  * @p: pointer to user data
  *
@@ -2434,7 +2434,7 @@ static int tiocsetd(struct tty_struct *tty, int __u=
ser *p)
 }
=20
 /**
- * tiocgetd	-	get line discipline
+ * tiocgetd - get line discipline
  * @tty: tty device
  * @p: pointer to user data
  *
@@ -2457,7 +2457,7 @@ static int tiocgetd(struct tty_struct *tty, int __u=
ser *p)
 }
=20
 /**
- * send_break	-	performed time break
+ * send_break - performed time break
  * @tty: device to break on
  * @duration: timeout in mS
  *
@@ -2495,7 +2495,7 @@ static int send_break(struct tty_struct *tty, unsig=
ned int duration)
 }
=20
 /**
- * tty_tiocmget		-	get modem status
+ * tty_tiocmget - get modem status
  * @tty: tty device
  * @p: pointer to result
  *
@@ -2518,7 +2518,7 @@ static int tty_tiocmget(struct tty_struct *tty, int=
 __user *p)
 }
=20
 /**
- * tty_tiocmset		-	set modem status
+ * tty_tiocmset - set modem status
  * @tty: tty device
  * @cmd: command - clear bits, set bits or set all
  * @p: pointer to desired bits
@@ -2559,7 +2559,7 @@ static int tty_tiocmset(struct tty_struct *tty, uns=
igned int cmd,
 }
=20
 /**
- * tty_get_icount	-	get tty statistics
+ * tty_get_icount - get tty statistics
  * @tty: tty device
  * @icount: output parameter
  *
@@ -3122,7 +3122,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driv=
er *driver, int idx)
 }
=20
 /**
- * tty_put_char	- write one character to a tty
+ * tty_put_char - write one character to a tty
  * @tty: tty
  * @ch: character to write
  *
@@ -3300,7 +3300,7 @@ void tty_unregister_device(struct tty_driver *drive=
r, unsigned index)
 EXPORT_SYMBOL(tty_unregister_device);
=20
 /**
- * __tty_alloc_driver -- allocate tty driver
+ * __tty_alloc_driver - allocate tty driver
  * @lines: count of lines this driver can handle at most
  * @owner: module which is responsible for this driver
  * @flags: some of %TTY_DRIVER_ flags, will be set in driver->flags
@@ -3393,7 +3393,7 @@ static void destruct_tty_driver(struct kref *kref)
 }
=20
 /**
- * tty_driver_kref_put -- drop a reference to a tty driver
+ * tty_driver_kref_put - drop a reference to a tty driver
  * @driver: driver of which to drop the reference
  *
  * The final put will destroy and free up the driver.
@@ -3405,7 +3405,7 @@ void tty_driver_kref_put(struct tty_driver *driver)
 EXPORT_SYMBOL(tty_driver_kref_put);
=20
 /**
- * tty_register_driver -- register a tty driver
+ * tty_register_driver - register a tty driver
  * @driver: driver to register
  *
  * Called by a tty driver to register itself.
@@ -3470,7 +3470,7 @@ int tty_register_driver(struct tty_driver *driver)
 EXPORT_SYMBOL(tty_register_driver);
=20
 /**
- * tty_unregister_driver -- unregister a tty driver
+ * tty_unregister_driver - unregister a tty driver
  * @driver: driver to unregister
  *
  * Called by a tty driver to unregister itself.
--=20
2.30.2

